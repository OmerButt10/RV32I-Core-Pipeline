package SC

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import scala.io.Source

class HazardDetection extends Module {
  val io = IO(new Bundle {
    val IF_ID_INST    = Input(UInt(32.W)) // Current instruction in the Decode stage
    val ID_EX_MEMREAD = Input(Bool())     // MEMREAD control signal from ID/EX pipeline register
    val ID_EX_REGRD   = Input(UInt(5.W))  // Destination register of the instruction in the Execution stage
    val pc_in         = Input(SInt(32.W)) // PC value of the next instruction
    val in_pc4    = Input(SInt(32.W)) // PC value of the current instruction

    val inst_forward     = Output(Bool())   // Control signal to reload the current instruction
    val pc_forward       = Output(Bool())   // Control signal to update the PC value
    val ctrl_forward     = Output(Bool())   // Control signal to manage control outputs
    val inst_out         = Output(UInt(32.W))  // Output instruction to be fed into the IF/ID pipeline register
    val pc_out           = Output(SInt(32.W))  // PC value to update the PC
    val pc4_out   = Output(SInt(32.W))  // PC value of the current instruction to feed into IF/ID pipeline register
  })

  // Extracting source registers from the current instruction
  val rs1 = io.IF_ID_INST(19, 15)
  val rs2 = io.IF_ID_INST(24, 20)

  io.inst_forward := false.B
  io.pc_forward := false.B
  io.ctrl_forward := false.B

  io.inst_out := io.IF_ID_INST
  io.pc_out := io.pc_in
  io.pc4_out := io.pc_in

  // Detecting hazard
  when(io.ID_EX_MEMREAD && ((io.ID_EX_REGRD === rs1) || (io.ID_EX_REGRD === rs2))) {
    // Hazard detected
    io.inst_forward := true.B
    io.pc_forward := true.B
    io.ctrl_forward := true.B
    io.inst_out := io.IF_ID_INST // Reload current instruction
    io.pc_out := io.pc4_out   // Preserve current PC
    io.pc4_out := io.pc_in // Preserve current instruction PC
  }
}
