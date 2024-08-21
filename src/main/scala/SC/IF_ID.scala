package SC

import chisel3._
import chisel3.util._

class IF_ID extends Module {
    val io = IO(new Bundle {
        val pc_in = Input(SInt(32.W))
        val pc_out = Output(SInt(32.W))

        val pc_in4 = Input(SInt(32.W))
        val pc_out4 = Output(SInt(32.W))

        val instr_in = Input(UInt(32.W))
        val instr_out = Output(UInt(32.W))
    })

    // Initialize registers with default values
    val RegPC = RegInit(0.S(32.W))
    val RegPC4 = RegInit(0.S(32.W))
    val RegINSTR = RegInit(0.U(32.W))
    
    // Update registers with inputs on each clock edge
    RegPC := io.pc_in
    RegPC4 := io.pc_in4
    RegINSTR := io.instr_in

    // Drive outputs from the registers
    io.pc_out := RegPC
    io.pc_out4 := RegPC4
    io.instr_out := RegINSTR
}
