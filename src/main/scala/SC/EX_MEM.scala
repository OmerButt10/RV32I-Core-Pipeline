package SC
import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import scala.io.Source

class EX_MEM extends Module {
  val io = IO(new Bundle {

    // Inputs from ID/EX stage
    val id_ex_memWr = Input(Bool())
    val id_ex_memRd = Input(Bool())
    val id_ex_memToReg = Input(Bool())
    val id_ex_rs2 = Input(UInt(32.W))
    val id_ex_rdSel = Input(UInt(5.W)) 
    val id_ex_rs2Sel = Input(UInt(5.W)) 
    val alu_output = Input(UInt(32.W))
    val id_ex_regWr = Input(Bool())

    // Outputs to MEM/WB stage
    val ex_mem_memWr_out = Output(Bool())
    val ex_mem_memRd_out = Output(Bool())
    val ex_mem_memToReg_out = Output(Bool())
    val ex_mem_rs2_output = Output(UInt(32.W))
    val ex_mem_rdSel_output = Output(UInt(5.W))
    val ex_mem_rs2Sel_output = Output(UInt(5.W))
    val ex_mem_alu_output = Output(UInt(32.W))
    val ex_mem_regWr_out = Output(Bool())
  })

  // Register definitions
  val regMemWr = RegInit(false.B)
  val regMemRd = RegInit(false.B)
  val regMemToReg = RegInit(false.B)
  val regRs2 = RegInit(0.U(32.W))
  val regRdSel = RegInit(0.U(5.W))
  val regRs2Sel = RegInit(0.U(5.W))
  val regAluOutput = RegInit(0.U(32.W))
  val regRegWr = RegInit(false.B)

  // Update registers with inputs
  regMemWr := io.id_ex_memWr
  regMemRd := io.id_ex_memRd
  regMemToReg := io.id_ex_memToReg
  regRs2 := io.id_ex_rs2
  regRdSel := io.id_ex_rdSel
  regRs2Sel := io.id_ex_rs2Sel
  regAluOutput := io.alu_output
  regRegWr := io.id_ex_regWr

  // Output assignments
  io.ex_mem_memWr_out := regMemWr
  io.ex_mem_memRd_out := regMemRd
  io.ex_mem_memToReg_out := regMemToReg
  io.ex_mem_rs2_output := regRs2
  io.ex_mem_rdSel_output := regRdSel
  io.ex_mem_rs2Sel_output := regRs2Sel
  io.ex_mem_alu_output := regAluOutput
  io.ex_mem_regWr_out := regRegWr
}

