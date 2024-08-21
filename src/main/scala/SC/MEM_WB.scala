package SC

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import scala.io.Source

class MEM_WB extends Module {
  val io = IO(new Bundle {
    val EX_MEM_REGWR = Input(Bool())
    val EX_MEM_MEMTOREG = Input(Bool())
    val EX_MEM_RDSEL = Input(UInt(5.W))
    val EX_MEM_MEMRD = Input(Bool())
    val in_dataMem_data = Input(UInt(32.W))
    val in_alu_output = Input(UInt(32.W))

    val mem_wb_regWr_output = Output(Bool())
    val mem_wb_memToReg_output = Output(Bool())
    val mem_wb_rdSel_output = Output(UInt(5.W))
    val mem_wb_memRd_output = Output(Bool())
    val mem_wb_dataMem_data = Output(UInt(32.W))
    val mem_wb_alu_output = Output(UInt(32.W))
  })

  // Registers to hold the pipeline values
  val Reg_MEM_WB_REGWR = RegInit(false.B)
  val Reg_MEM_WB_MEMTOREG = RegInit(false.B)
  val Reg_MEM_WB_RDSEL = RegInit(0.U(5.W))
  val Reg_MEM_WB_MEMRD = RegInit(false.B)
  val Reg_dataMem_data = RegInit(0.U(32.W))
  val Reg_alu_output = RegInit(0.U(32.W))

  // Assigning input values to the registers
  Reg_MEM_WB_REGWR := io.EX_MEM_REGWR
  Reg_MEM_WB_MEMTOREG := io.EX_MEM_MEMTOREG
  Reg_MEM_WB_RDSEL := io.EX_MEM_RDSEL
  Reg_MEM_WB_MEMRD := io.EX_MEM_MEMRD
  Reg_dataMem_data := io.in_dataMem_data
  Reg_alu_output := io.in_alu_output

  // Connecting registers to outputs
  io.mem_wb_regWr_output := Reg_MEM_WB_REGWR
  io.mem_wb_memToReg_output := Reg_MEM_WB_MEMTOREG
  io.mem_wb_rdSel_output := Reg_MEM_WB_RDSEL
  io.mem_wb_memRd_output := Reg_MEM_WB_MEMRD
  io.mem_wb_dataMem_data := Reg_dataMem_data
  io.mem_wb_alu_output := Reg_alu_output
}
