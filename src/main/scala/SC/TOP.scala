package SC

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import scala.io.Source

// Top-level module for your SC design
class TOP extends Module {
    val io = IO(new Bundle {
        val out = Output(UInt(32.W))
    })
    
    // Module instantiations
    val Instr_Mod = Module(new Instruction_Memory)
    val CU_Mod = Module(new Control_Unit)
    val ALU_Mod = Module(new ALU)
    val Data_Memory_Mod = Module(new Data_Memory)
    val Immediate_Gen_Mod = Module(new ImmdValGen)
    val PC_Mod = Module(new PC)
    val Jalr_Mod = Module(new Jalr)
    val Reg_Mod = Module(new Register_File)
    val ALU_Branch = Module(new ALU_Branch_Control)

    // Modules for pipelining
    val ifId = Module(new IF_ID)
    val idEx = Module(new ID_EX)
    val ExMem = Module(new EX_MEM)
    val MemWb = Module(new MEM_WB)
    val FwdUnit = Module(new ForwardingUnit)
    val HazardDetect = Module(new HazardDetection)
//    val branch_fwd = Module(new Branch_Fwd)

    // Prevent optimization tools from touching these modules
    dontTouch(Reg_Mod.io)
    dontTouch(Jalr_Mod.io)
    dontTouch(Immediate_Gen_Mod.io)
    dontTouch(Data_Memory_Mod.io)
    dontTouch(ALU_Mod.io)
    dontTouch(ALU_Branch.io)
    dontTouch(ifId.io)
    dontTouch(idEx.io)
    dontTouch(ExMem.io)
    dontTouch(MemWb.io)
    dontTouch(FwdUnit.io)
    dontTouch(HazardDetect.io)
  //  dontTouch(branch_fwd.io)

   ALU_Branch.io.CU_Branch_alu_inx := 0.U
   ALU_Branch.io.CU_Branch_alu_iny := 0.U
     ALU_Branch.io.fnct3 := 0.U 
     ALU_Branch.io.CU_Branch := 0.U 

    // ALU output mux for branching
    val Main_ALU_Mux = Mux(ALU_Mod.io.CU_Branch_taken, ALU_Mod.io.in_A ,ALU_Mod.io.in_B)

    // Branch condition and mux
    val br = ALU_Mod.io.CU_Branch_taken && CU_Mod.io.CU_Branch
    val Br_Mux = Mux(br, Immediate_Gen_Mod.io.immd_se_SB, PC_Mod.io.pc4.asSInt())

    // PC Input selection
    val pc_input = MuxLookup(CU_Mod.io.CU_Next_PC, 0.S, Array(
        "b00".U -> PC_Mod.io.pc4.asSInt(),
        "b01".U -> Br_Mux.asSInt(),
        "b10".U -> Immediate_Gen_Mod.io.immd_se_UJ,
        "b11".U -> Jalr_Mod.io.imm
    ))  
    dontTouch(pc_input)
    PC_Mod.io.pc := pc_input

    // PC-Start and instruction fetch
    Instr_Mod.io.memory_address := PC_Mod.io.pc1(21,2)

    // IF_ID Pipeline Register
    ifId.io.pc_in := PC_Mod.io.pc
    ifId.io.pc_in4 := PC_Mod.io.pc4
    ifId.io.instr_in := Instr_Mod.io.memory_instruction

    // Control Unit
    CU_Mod.io.CU_Opcode := Instr_Mod.io.memory_instruction(6, 0)

    // Register File operations
    Reg_Mod.io.ReadReg1 := Instr_Mod.io.memory_instruction(19, 15)
    Reg_Mod.io.ReadReg2 := Instr_Mod.io.memory_instruction(24, 20)
    Reg_Mod.io.WriteReg  := Instr_Mod.io.memory_instruction(11, 7)
    Reg_Mod.io.RegWrite := CU_Mod.io.CU_RegWrite 
    Reg_Mod.io.WriteData := Mux(CU_Mod.io.CU_MemToReg, Data_Memory_Mod.io.Data_Mem_output, ALU_Mod.io.out.asSInt())

    // Immediate Generation
    Immediate_Gen_Mod.io.Imm_instr := Instr_Mod.io.memory_instruction.asSInt()
    Immediate_Gen_Mod.io.Imm_pc := ifId.io.pc_out

    // Data Memory operations
    Data_Memory_Mod.io.Data_Mem_address := ExMem.io.alu_output(11,2)
    Data_Memory_Mod.io.Data_Mem_data := ExMem.io.ex_mem_rs2_output.asSInt()
    Data_Memory_Mod.io.Data_Mem_write := ExMem.io.ex_mem_memWr_out
    Data_Memory_Mod.io.Data_Mem_read := ExMem.io.ex_mem_memWr_out

      // IF/ID pipeline register outputs to ID/EX inputs
    idEx.io.IF_ID_pc := ifId.io.pc_out
    idEx.io.rs1_sel_in := Reg_Mod.io.ReadReg1
    idEx.io.rs2_sel_in := Reg_Mod.io.ReadReg2
    idEx.io.rs1_in := Reg_Mod.io.ReadData1.asUInt
    idEx.io.rs2_in := Reg_Mod.io.ReadData2.asUInt
    idEx.io.imm := ifId.io.pc_in.asUInt()
    idEx.io.rd_sel_in := ifId.io.instr_out(11, 7)
    idEx.io.func3_in := ifId.io.instr_out(14, 12)
    idEx.io.func7_in := ifId.io.instr_out(31, 25)
    idEx.io.ctrl_nextPc_sel_in := CU_Mod.io.CU_Next_PC

    // Operand-A-Selector using MuxLookup for selecting ALU input
    val ALU_Mux_1 = Wire(SInt())
    ALU_Mux_1 := MuxLookup(CU_Mod.io.CU_InA, 0.S, Array(
        0.U -> Reg_Mod.io.ReadData1,
        1.U -> PC_Mod.io.pc1.asSInt(),
        2.U -> PC_Mod.io.pc4.asSInt(),
        3.U -> Reg_Mod.io.ReadData1
    ))

    // EX/MEM Pipeline Register configurations
    ExMem.io.id_ex_memWr := idEx.io.ctrl_MemWr_out
    ExMem.io.id_ex_memRd := idEx.io.ctrl_MemRd_out
    ExMem.io.id_ex_memToReg := idEx.io.ctrl_MemtoReg_out
    ExMem.io.alu_output := ALU_Mod.io.out
    ExMem.io.id_ex_rdSel := idEx.io.rd_sel_out
    ExMem.io.id_ex_rs2Sel := idEx.io.rs2_sel_out
    ExMem.io.id_ex_regWr := idEx.io.ctrl_RegWr_out
    ExMem.io.id_ex_rs2:= ALU_Mux_1.asUInt()

    // MEM/WB Stage for writing back to registers
    MemWb.io.EX_MEM_MEMTOREG := ExMem.io.ex_mem_memToReg_out
    MemWb.io.in_dataMem_data := Data_Memory_Mod.io.Data_Mem_output.asUInt()
    MemWb.io.in_alu_output := ExMem.io.alu_output
    MemWb.io.EX_MEM_RDSEL := ExMem.io.ex_mem_rdSel_output
    MemWb.io.EX_MEM_MEMRD := ExMem.io.ex_mem_memRd_out
    MemWb.io.EX_MEM_REGWR := ExMem.io.ex_mem_memToReg_out

    // Forward Unit for handling data hazards
    FwdUnit.io.exMemRdAddr := ExMem.io.ex_mem_memWr_out
    FwdUnit.io.exMemRegWrite := MemWb.io.EX_MEM_REGWR
    FwdUnit.io.memWbRdAddr := ExMem.io.ex_mem_rdSel_output
    FwdUnit.io.memWbRegWrite := MemWb.io.EX_MEM_RDSEL
    FwdUnit.io.idExRs1Addr := idEx.io.rs1_sel_out
    FwdUnit.io.idExRs2Addr := idEx.io.rs2_sel_out

    // Forwarding MUXes for Operand A and B
    when(idEx.io.ctrl_OpA_sel_out === "b10".U) {
        ALU_Mod.io.in_A := idEx.io.pc_out.asUInt()
    }.otherwise {
        ALU_Mod.io.in_A := MuxCase(idEx.io.rs1_out, Seq(
            (FwdUnit.io.forwardA === "b01".U) -> ExMem.io.ex_mem_alu_output,
            (FwdUnit.io.forwardA === "b10".U) -> Reg_Mod.io.WriteData.asUInt(),
            (FwdUnit.io.forwardA === "b00".U) -> idEx.io.rs1_out
        ))
    }

    when(idEx.io.ctrl_OpB_sel_out === "b1".U) {
        ALU_Mod.io.in_B := idEx.io.imm_out
        ExMem.io.id_ex_rs2 := MuxCase(idEx.io.rs2_out, Seq(
            (FwdUnit.io.forwardB === "b01".U) -> ExMem.io.alu_output,
            (FwdUnit.io.forwardB === "b10".U) -> Reg_Mod.io.WriteData.asUInt(),
            (FwdUnit.io.forwardB === "b00".U) -> idEx.io.rs2_out
        ))
    }.otherwise {
        ALU_Mod.io.in_B := MuxCase(idEx.io.rs2_out, Seq(
            (FwdUnit.io.forwardB === "b01".U) -> ExMem.io.alu_output,
            (FwdUnit.io.forwardB === "b10".U) -> Reg_Mod.io.WriteData.asUInt(),
            (FwdUnit.io.forwardB === "b00".U) -> idEx.io.rs2_out
        ))
        ExMem.io.id_ex_rs2 := ALU_Mod.io.in_B
    }

    // Immediate Generator output mux for various immediate types
    val Imm_Mux_Output = Wire(SInt())
    Imm_Mux_Output := MuxLookup(CU_Mod.io.CU_Extend_sel, 0.S, Array(
        0.U -> Immediate_Gen_Mod.io.immd_se_I,
        1.U -> Immediate_Gen_Mod.io.immd_se_S,
        2.U -> Immediate_Gen_Mod.io.immd_se_U
    ))

    // Jalr Module Inputs
    Jalr_Mod.io.rd := Reg_Mod.io.ReadData1
    Jalr_Mod.io.rs1 := Imm_Mux_Output.asSInt()


    // Handle instruction forwarding
    when(HazardDetect.io.inst_forward) {
      ifId.io.instr_in := HazardDetect.io.inst_out
      ifId.io.pc_in := HazardDetect.io.pc_out
    }.otherwise {
      ifId.io.instr_in := Instr_Mod.io.memory_instruction
    }

    // Hazard Detection
    HazardDetect.io.ID_EX_MEMREAD := idEx.io.ctrl_MemRd_out
    HazardDetect.io.ID_EX_REGRD := idEx.io.rd_sel_out
    HazardDetect.io.IF_ID_INST := ifId.io.instr_out
    HazardDetect.io.pc_in := ifId.io.pc_out
    HazardDetect.io.in_pc4 := ifId.io.pc_out4
    
    // Handle PC forwarding
    when(HazardDetect.io.pc_forward) {
      PC_Mod.io.pc := HazardDetect.io.pc_out
    }.otherwise {
      when(CU_Mod.io.CU_Next_PC === "b01".U) {
        when(ALU_Branch.io.CU_Branch_taken === 1.U && CU_Mod.io.CU_Branch === 1.U) {
          PC_Mod.io.pc := Immediate_Gen_Mod.io.immd_se_SB
          ifId.io.pc_in := 0.S
          ifId.io.instr_in := 0.U
        }.otherwise {
          PC_Mod.io.pc := PC_Mod.io.pc4
        }
      }.elsewhen(CU_Mod.io.CU_Next_PC === "b10".U) {
        PC_Mod.io.pc := Immediate_Gen_Mod.io.immd_se_UJ
        ifId.io.pc_in4 := 0.S
        ifId.io.instr_in := 0.U
      }.otherwise {
        PC_Mod.io.pc := PC_Mod.io.pc4
      }
    }

    // Handle control signal forwarding
    when(HazardDetect.io.ctrl_forward) {
      idEx.io.ctrl_MemWr_in := 0.U
      idEx.io.ctrl_MemRd_in := 0.U
      idEx.io.ctrl_Branch_in := 0.U
      idEx.io.ctrl_RegWr_in := 0.U
      idEx.io.ctrl_MemtoReg_in := 0.U
      idEx.io.ctrl_ALUOP_in := 0.U
      idEx.io.ctrl_OpA_sel_in := 0.U
      idEx.io.ctrl_OpB_sel_in := 0.U
      idEx.io.ctrl_nextPc_sel_in := 0.U
    }.otherwise {
      idEx.io.ctrl_MemWr_in := CU_Mod.io.CU_MemWrite
      idEx.io.ctrl_MemRd_in := CU_Mod.io.CU_MemRead
      idEx.io.ctrl_Branch_in := CU_Mod.io.CU_Branch
      idEx.io.ctrl_RegWr_in := CU_Mod.io.CU_RegWrite
      idEx.io.ctrl_MemtoReg_in := CU_Mod.io.CU_MemRead
      idEx.io.ctrl_ALUOP_in := CU_Mod.io.CU_ALU_op
      idEx.io.ctrl_OpA_sel_in := CU_Mod.io.CU_InA
      idEx.io.ctrl_OpB_sel_in := CU_Mod.io.CU_InB
      idEx.io.ctrl_nextPc_sel_in := CU_Mod.io.CU_Next_PC
    }

    //Operand Data Selection Mux 
    val ALU_Mux_2 = Mux(CU_Mod.io.CU_InB,Imm_Mux_Output.asSInt(),Reg_Mod.io.ReadData2)

    //ALU Control
    val Func3 = Instr_Mod.io.memory_instruction(14,12)
    val Func7 = Instr_Mod.io.memory_instruction(30)
    
    ALU_Mod.io.alu_Op := CU_Mod.io.CU_ALU_op  

    //ALU
    ALU_Mod.io.in_A := ALU_Mux_1.asUInt()
    ALU_Mod.io.in_B := ALU_Mux_2.asUInt()

    //ALU-Branch
    ALU_Mod.io.func3 := CU_Mod.io.CU_Opcode
    // ALU_Mod.io.in_A := Reg_Mod.io.ReadData1.asUInt()
    // ALU_Mod.io.in_B := Reg_Mod.io.ReadData2.asUInt()
    

io.out := CU_Mod.io.CU_MemWrite
  }





