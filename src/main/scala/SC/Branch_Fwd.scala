package SC
import chisel3._
import chisel3.util._

class Branch_Fwd extends Module {
  val io = IO(new Bundle {
    val idExRegRdAddr = Input(UInt(5.W))
    val idExMemRead = Input(Bool())
    val exMemRegRdAddr = Input(UInt(5.W))
    val exMemMemRead = Input(Bool())
    val memWbRegRdAddr = Input(UInt(5.W))
    val memWbMemRead = Input(Bool())
    val rs1Addr = Input(UInt(5.W))
    val rs2Addr = Input(UInt(5.W))
    val branch = Input(Bool())
    val forwardA = Output(UInt(4.W))
    val forwardB = Output(UInt(4.W))
  })

  io.forwardA := 0.U
  io.forwardB := 0.U

  when(io.branch) { 
    // ALU Hazard
    when(io.idExRegRdAddr =/= 0.U && !io.idExMemRead && (io.idExRegRdAddr === io.rs1Addr || io.idExRegRdAddr === io.rs2Addr)) {
      io.forwardA := Mux(io.idExRegRdAddr === io.rs1Addr, "b0001".U, io.forwardA)
      io.forwardB := Mux(io.idExRegRdAddr === io.rs2Addr, "b0001".U, io.forwardB)
    }
    // EX/MEM Hazard
    when(io.exMemRegRdAddr =/= 0.U && !io.exMemMemRead &&
      !(io.idExRegRdAddr =/= 0.U && (io.idExRegRdAddr === io.rs1Addr || io.idExRegRdAddr === io.rs2Addr)) &&
      (io.exMemRegRdAddr === io.rs1Addr || io.exMemRegRdAddr === io.rs2Addr)) {
      io.forwardA := Mux(io.exMemRegRdAddr === io.rs1Addr, "b0010".U, io.forwardA)
      io.forwardB := Mux(io.exMemRegRdAddr === io.rs2Addr, "b0010".U, io.forwardB)
    }.elsewhen(io.exMemRegRdAddr =/= 0.U && io.exMemMemRead &&
      !(io.idExRegRdAddr =/= 0.U && (io.idExRegRdAddr === io.rs1Addr || io.idExRegRdAddr === io.rs2Addr)) &&
      (io.exMemRegRdAddr === io.rs1Addr || io.exMemRegRdAddr === io.rs2Addr)) {
      io.forwardA := Mux(io.exMemRegRdAddr === io.rs1Addr, "b0100".U, io.forwardA)
      io.forwardB := Mux(io.exMemRegRdAddr === io.rs2Addr, "b0100".U, io.forwardB)
    }
    // MEM/WB Hazard
    when(io.memWbRegRdAddr =/= 0.U && !io.memWbMemRead &&
      !(io.idExRegRdAddr =/= 0.U && (io.idExRegRdAddr === io.rs1Addr || io.idExRegRdAddr === io.rs2Addr)) &&
      !(io.exMemRegRdAddr =/= 0.U && (io.exMemRegRdAddr === io.rs1Addr || io.exMemRegRdAddr === io.rs2Addr)) &&
      (io.memWbRegRdAddr === io.rs1Addr || io.memWbRegRdAddr === io.rs2Addr)) {
      io.forwardA := Mux(io.memWbRegRdAddr === io.rs1Addr, "b0011".U, io.forwardA)
      io.forwardB := Mux(io.memWbRegRdAddr === io.rs2Addr, "b0011".U, io.forwardB)
    }.elsewhen(io.memWbRegRdAddr =/= 0.U && io.memWbMemRead &&
      !(io.idExRegRdAddr =/= 0.U && (io.idExRegRdAddr === io.rs1Addr || io.idExRegRdAddr === io.rs2Addr)) &&
      !(io.exMemRegRdAddr =/= 0.U && (io.exMemRegRdAddr === io.rs1Addr || io.exMemRegRdAddr === io.rs2Addr)) &&
      (io.memWbRegRdAddr === io.rs1Addr || io.memWbRegRdAddr === io.rs2Addr)) {
      io.forwardA := Mux(io.memWbRegRdAddr === io.rs1Addr, "b0101".U, io.forwardA)
      io.forwardB := Mux(io.memWbRegRdAddr === io.rs2Addr, "b0101".U, io.forwardB)
    }
  }.otherwise {
    // ALU Hazard
    when(io.idExRegRdAddr =/= 0.U && !io.idExMemRead && io.idExRegRdAddr === io.rs1Addr) {
      io.forwardA := "b0110".U
    }
    // EX/MEM Hazard
    when(io.exMemRegRdAddr =/= 0.U && !io.exMemMemRead && !(io.idExRegRdAddr =/= 0.U && io.idExRegRdAddr === io.rs1Addr) && io.exMemRegRdAddr === io.rs1Addr) {
      io.forwardA := "b0111".U
    }.elsewhen(io.exMemRegRdAddr =/= 0.U && io.exMemMemRead && !(io.idExRegRdAddr =/= 0.U && io.idExRegRdAddr === io.rs1Addr) && io.exMemRegRdAddr === io.rs1Addr) {
      io.forwardA := "b1001".U
    }
    // MEM/WB Hazard
    when(io.memWbRegRdAddr =/= 0.U && !io.memWbMemRead && !(io.idExRegRdAddr =/= 0.U && io.idExRegRdAddr === io.rs1Addr) && !(io.exMemRegRdAddr =/= 0.U && io.exMemRegRdAddr === io.rs1Addr) && io.memWbRegRdAddr === io.rs1Addr) {
      io.forwardA := "b1000".U
    }.elsewhen(io.memWbRegRdAddr =/= 0.U && io.memWbMemRead && !(io.idExRegRdAddr =/= 0.U && io.idExRegRdAddr === io.rs1Addr) && !(io.exMemRegRdAddr =/= 0.U && io.exMemRegRdAddr === io.rs1Addr) && io.memWbRegRdAddr === io.rs1Addr) {
      io.forwardA := "b1010".U
    }
  }
}
