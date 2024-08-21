package object SC {
import chisel3._
import chisel3.util._

class ForwardingUnit extends Module {
    val io = IO(new Bundle {
        val exMemRegWrite = Input(Bool())
        val memWbRegWrite = Input(Bool())
        val memWbRdAddr = Input(UInt(5.W))
        val exMemRdAddr = Input(UInt(5.W))
        val idExRs1Addr = Input(UInt(5.W))
        val idExRs2Addr = Input(UInt(5.W))
        val forwardA = Output(UInt(2.W))
        val forwardB = Output(UInt(2.W))
    })

    io.forwardA := 0.U
    io.forwardB := 0.U

    // Execution Hazard
    when(io.exMemRegWrite && io.exMemRdAddr =/= 0.U) {
        when(io.exMemRdAddr === io.idExRs1Addr) {
            io.forwardA := 1.U
        }
        when(io.exMemRdAddr === io.idExRs2Addr) {
            io.forwardB := 1.U
        }
    }

    // Memory Hazard
    when(io.memWbRegWrite && io.memWbRdAddr =/= 0.U) {
        when(io.memWbRdAddr === io.idExRs1Addr && !(io.exMemRegWrite && io.exMemRdAddr === io.idExRs1Addr)) {
            io.forwardA := 2.U
        }
        when(io.memWbRdAddr === io.idExRs2Addr && !(io.exMemRegWrite && io.exMemRdAddr === io.idExRs2Addr)) {
            io.forwardB := 2.U
        }
    }
}

}
