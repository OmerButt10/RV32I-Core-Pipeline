package SC

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import scala.io.Source


class StructuralDetectors extends Module {
  val io = IO(new Bundle {
    val rs1Addr = Input(UInt(5.W))
    val rs2Addr = Input(UInt(5.W))
    val memWbRegWrite = Input(Bool())
    val memWbRdAddr = Input(UInt(5.W))
    val forwardA = Output(Bool())
    val forwardB = Output(Bool())
  })

  // Default values
  io.forwardA := false.B
  io.forwardB := false.B

  // Forwarding logic for source register 1 (rs1)
  when(io.memWbRegWrite && (io.memWbRdAddr === io.rs1Addr)) {
    io.forwardA := true.B
  } .otherwise {
    io.forwardA := false.B
  }

  // Forwarding logic for source register 2 (rs2)
  when(io.memWbRegWrite && (io.memWbRdAddr === io.rs2Addr)) {
    io.forwardB := true.B
  } .otherwise {
    io.forwardB := false.B
  }
}



