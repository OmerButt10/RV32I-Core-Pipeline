package SC

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import scala.io.Source

class ID_EX extends Module {
  val io = IO(new Bundle {
    val IF_ID_pc = Input(SInt(32.W))
    val pc_out = Output(SInt(32.W))

    val rs1_sel_in = Input(UInt(5.W))
    val rs1_sel_out = Output(UInt(5.W))

    val rs2_sel_in = Input(UInt(5.W))
    val rs2_sel_out = Output(UInt(5.W))

    val rs1_in = Input(UInt(32.W))
    val rs1_out = Output(UInt(32.W))

    val rs2_in = Input(UInt(32.W))
    val rs2_out = Output(UInt(32.W))

    val imm = Input(UInt(32.W))
    val imm_out = Output(UInt(32.W))

    val rd_sel_in = Input(UInt(5.W))
    val rd_sel_out = Output(UInt(5.W))

    val func3_in = Input(UInt(3.W))
    val func3_out = Output(UInt(3.W))

    val func7_in = Input(UInt(7.W))
    val func7_out = Output(UInt(7.W))

    val ctrl_MemWr_in = Input(Bool())
    val ctrl_MemWr_out = Output(Bool())

    val ctrl_MemRd_in = Input(Bool())
    val ctrl_MemRd_out = Output(Bool())

    val ctrl_Branch_in = Input(Bool())
    val ctrl_Branch_out = Output(Bool())

    val ctrl_RegWr_in = Input(Bool())
    val ctrl_RegWr_out = Output(Bool())

    val ctrl_MemtoReg_in = Input(Bool())
    val ctrl_MemtoReg_out = Output(Bool())

    val ctrl_ALUOP_in = Input(UInt(4.W))
    val ctrl_ALUOP_out = Output(UInt(4.W))

    val ctrl_OpA_sel_in = Input(Bool())
    val ctrl_OpA_sel_out = Output(Bool())

    val ctrl_OpB_sel_in = Input(Bool())
    val ctrl_OpB_sel_out = Output(Bool())

    val ctrl_nextPc_sel_in = Input(UInt(2.W))
    val ctrl_nextPc_sel_out = Output(UInt(2.W))
  })

  // Flip-flop register definitions following the original naming convention
  val RegID_EX_PC = RegInit(0.S(32.W))
  val Regrs1_sel = RegInit(0.U(5.W))
  val Regrs2_sel = RegInit(0.U(5.W))
  val Regrs1 = RegInit(0.U(32.W))
  val Regrs2 = RegInit(0.U(32.W))
  val Regimm = RegInit(0.U(32.W))
  val Regrd_sel = RegInit(0.U(5.W))
  val Regfunc3 = RegInit(0.U(3.W))
  val Regfunc7 = RegInit(0.U(7.W))
  val Reg_Ctrl_MemWr = RegInit(false.B)
  val Reg_Ctrl_MemRd = RegInit(false.B)
  val Reg_Ctrl_Branch = RegInit(false.B)
  val Reg_Ctrl_RegWr = RegInit(false.B)
  val Reg_Ctrl_MemtoReg = RegInit(false.B)
  val Reg_Ctrl_AluOp = RegInit(0.U(4.W))
  val Reg_Ctrl_OpA = RegInit(false.B)
  val Reg_Ctrl_OpB = RegInit(false.B)
  val Reg_Ctrl_nextPc = RegInit(0.U(2.W))

  // Register updates on clock edge
  RegID_EX_PC := io.IF_ID_pc
  Regrs1_sel := io.rs1_sel_in
  Regrs2_sel := io.rs2_sel_in
  Regrs1 := io.rs1_in
  Regrs2 := io.rs2_in
  Regimm := io.imm
  Regrd_sel := io.rd_sel_in
  Regfunc3 := io.func3_in
  Regfunc7 := io.func7_in
  Reg_Ctrl_MemWr := io.ctrl_MemWr_in
  Reg_Ctrl_MemRd := io.ctrl_MemRd_in
  Reg_Ctrl_Branch := io.ctrl_Branch_in
  Reg_Ctrl_RegWr := io.ctrl_RegWr_in
  Reg_Ctrl_MemtoReg := io.ctrl_MemtoReg_in
  Reg_Ctrl_AluOp := io.ctrl_ALUOP_in
  Reg_Ctrl_OpA := io.ctrl_OpA_sel_in
  Reg_Ctrl_OpB := io.ctrl_OpB_sel_in
  Reg_Ctrl_nextPc := io.ctrl_nextPc_sel_in

  // Output connections
  io.pc_out := RegID_EX_PC
  io.rs1_sel_out := Regrs1_sel
  io.rs2_sel_out := Regrs2_sel
  io.rs1_out := Regrs1
  io.rs2_out := Regrs2
  io.imm_out := Regimm
  io.rd_sel_out := Regrd_sel
  io.func3_out := Regfunc3
  io.func7_out := Regfunc7
  io.ctrl_MemWr_out := Reg_Ctrl_MemWr
  io.ctrl_MemRd_out := Reg_Ctrl_MemRd
  io.ctrl_Branch_out := Reg_Ctrl_Branch
  io.ctrl_RegWr_out := Reg_Ctrl_RegWr
  io.ctrl_MemtoReg_out := Reg_Ctrl_MemtoReg
  io.ctrl_ALUOP_out := Reg_Ctrl_AluOp
  io.ctrl_OpA_sel_out := Reg_Ctrl_OpA
  io.ctrl_OpB_sel_out := Reg_Ctrl_OpB
  io.ctrl_nextPc_sel_out := Reg_Ctrl_nextPc
}
