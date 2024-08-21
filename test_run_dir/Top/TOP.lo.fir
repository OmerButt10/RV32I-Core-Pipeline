circuit TOP :
  module Instruction_Memory :
    input clock : Clock
    input reset : UInt<1>
    input io_memory_address : UInt<32>
    output io_memory_instruction : UInt<32>

    mem mem : @[Instruction-Memory.scala 15:16]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_memory_instruction_MPORT
      read-under-write => undefined
    node _io_memory_instruction_T = bits(io_memory_address, 9, 0) @[Instruction-Memory.scala 18:29]
    io_memory_instruction <= mem.io_memory_instruction_MPORT.data @[Instruction-Memory.scala 18:24]
    mem.io_memory_instruction_MPORT.addr <= _io_memory_instruction_T @[Instruction-Memory.scala 18:29]
    mem.io_memory_instruction_MPORT.en <= UInt<1>("h1") @[Instruction-Memory.scala 18:29]
    mem.io_memory_instruction_MPORT.clk <= clock @[Instruction-Memory.scala 18:29]

  module Control_Unit :
    input clock : Clock
    input reset : UInt<1>
    input io_CU_Opcode : UInt<7>
    output io_CU_MemWrite : UInt<1>
    output io_CU_Branch : UInt<1>
    output io_CU_MemRead : UInt<1>
    output io_CU_RegWrite : UInt<1>
    output io_CU_MemToReg : UInt<1>
    output io_CU_ALU_op : UInt<3>
    output io_CU_InA : UInt<2>
    output io_CU_InB : UInt<1>
    output io_CU_Extend_sel : UInt<2>
    output io_CU_Next_PC : UInt<2>

    node _T = eq(io_CU_Opcode, UInt<2>("h3")) @[Control-Unit.scala 20:23]
    node _T_1 = eq(io_CU_Opcode, UInt<4>("hf")) @[Control-Unit.scala 32:29]
    node _T_2 = eq(io_CU_Opcode, UInt<5>("h17")) @[Control-Unit.scala 32:64]
    node _T_3 = or(_T_1, _T_2) @[Control-Unit.scala 32:47]
    node _T_4 = eq(io_CU_Opcode, UInt<5>("h1b")) @[Control-Unit.scala 32:99]
    node _T_5 = or(_T_3, _T_4) @[Control-Unit.scala 32:82]
    node _T_6 = eq(io_CU_Opcode, UInt<6>("h3b")) @[Control-Unit.scala 32:134]
    node _T_7 = or(_T_5, _T_6) @[Control-Unit.scala 32:117]
    node _T_8 = eq(io_CU_Opcode, UInt<7>("h73")) @[Control-Unit.scala 32:169]
    node _T_9 = or(_T_7, _T_8) @[Control-Unit.scala 32:152]
    node _T_10 = eq(io_CU_Opcode, UInt<5>("h13")) @[Control-Unit.scala 45:28]
    node _T_11 = eq(io_CU_Opcode, UInt<6>("h23")) @[Control-Unit.scala 57:28]
    node _T_12 = eq(io_CU_Opcode, UInt<6>("h33")) @[Control-Unit.scala 69:28]
    node _T_13 = eq(io_CU_Opcode, UInt<6>("h37")) @[Control-Unit.scala 81:28]
    node _T_14 = eq(io_CU_Opcode, UInt<7>("h63")) @[Control-Unit.scala 96:28]
    node _T_15 = eq(io_CU_Opcode, UInt<7>("h67")) @[Control-Unit.scala 108:28]
    node _T_16 = eq(io_CU_Opcode, UInt<7>("h6f")) @[Control-Unit.scala 120:28]
    node _GEN_0 = validif(_T_16, UInt<1>("h0")) @[Control-Unit.scala 120:45 Control-Unit.scala 121:24]
    node _GEN_1 = validif(_T_16, UInt<1>("h1")) @[Control-Unit.scala 120:45 Control-Unit.scala 124:24]
    node _GEN_2 = validif(_T_16, UInt<2>("h3")) @[Control-Unit.scala 120:45 Control-Unit.scala 126:22]
    node _GEN_3 = validif(_T_16, UInt<2>("h2")) @[Control-Unit.scala 120:45 Control-Unit.scala 127:19]
    node _GEN_4 = mux(_T_15, UInt<1>("h0"), _GEN_0) @[Control-Unit.scala 108:45 Control-Unit.scala 109:24]
    node _GEN_5 = mux(_T_15, UInt<1>("h1"), _GEN_1) @[Control-Unit.scala 108:45 Control-Unit.scala 112:24]
    node _GEN_6 = mux(_T_15, UInt<2>("h3"), _GEN_2) @[Control-Unit.scala 108:45 Control-Unit.scala 114:22]
    node _GEN_7 = mux(_T_15, UInt<2>("h2"), _GEN_3) @[Control-Unit.scala 108:45 Control-Unit.scala 115:19]
    node _GEN_8 = mux(_T_15, UInt<2>("h3"), _GEN_3) @[Control-Unit.scala 108:45 Control-Unit.scala 118:23]
    node _GEN_9 = mux(_T_14, UInt<1>("h0"), _GEN_4) @[Control-Unit.scala 96:45 Control-Unit.scala 97:24]
    node _GEN_10 = mux(_T_14, UInt<1>("h1"), _GEN_4) @[Control-Unit.scala 96:45 Control-Unit.scala 98:22]
    node _GEN_11 = mux(_T_14, UInt<1>("h0"), _GEN_5) @[Control-Unit.scala 96:45 Control-Unit.scala 100:24]
    node _GEN_12 = mux(_T_14, UInt<2>("h2"), _GEN_6) @[Control-Unit.scala 96:45 Control-Unit.scala 102:22]
    node _GEN_13 = mux(_T_14, UInt<1>("h0"), _GEN_7) @[Control-Unit.scala 96:45 Control-Unit.scala 103:19]
    node _GEN_14 = mux(_T_14, UInt<1>("h1"), _GEN_8) @[Control-Unit.scala 96:45 Control-Unit.scala 106:23]
    node _GEN_15 = mux(_T_13, UInt<1>("h0"), _GEN_9) @[Control-Unit.scala 81:45 Control-Unit.scala 82:24]
    node _GEN_16 = mux(_T_13, UInt<1>("h0"), _GEN_10) @[Control-Unit.scala 81:45 Control-Unit.scala 83:22]
    node _GEN_17 = mux(_T_13, UInt<1>("h1"), _GEN_11) @[Control-Unit.scala 81:45 Control-Unit.scala 86:24]
    node _GEN_18 = mux(_T_13, UInt<3>("h6"), _GEN_12) @[Control-Unit.scala 81:45 Control-Unit.scala 88:22]
    node _GEN_19 = mux(_T_13, UInt<2>("h3"), _GEN_13) @[Control-Unit.scala 81:45 Control-Unit.scala 89:19]
    node _GEN_20 = mux(_T_13, UInt<1>("h1"), _GEN_9) @[Control-Unit.scala 81:45 Control-Unit.scala 90:19]
    node _GEN_21 = mux(_T_13, UInt<1>("h0"), _GEN_14) @[Control-Unit.scala 81:45 Control-Unit.scala 94:23]
    node _GEN_22 = mux(_T_12, UInt<1>("h0"), _GEN_15) @[Control-Unit.scala 69:45 Control-Unit.scala 70:24]
    node _GEN_23 = mux(_T_12, UInt<1>("h0"), _GEN_16) @[Control-Unit.scala 69:45 Control-Unit.scala 71:22]
    node _GEN_24 = mux(_T_12, UInt<1>("h1"), _GEN_17) @[Control-Unit.scala 69:45 Control-Unit.scala 73:24]
    node _GEN_25 = mux(_T_12, UInt<1>("h0"), _GEN_18) @[Control-Unit.scala 69:45 Control-Unit.scala 75:22]
    node _GEN_26 = mux(_T_12, UInt<1>("h0"), _GEN_19) @[Control-Unit.scala 69:45 Control-Unit.scala 76:19]
    node _GEN_27 = mux(_T_12, UInt<1>("h0"), _GEN_20) @[Control-Unit.scala 69:45 Control-Unit.scala 77:19]
    node _GEN_28 = mux(_T_12, UInt<1>("h0"), _GEN_21) @[Control-Unit.scala 69:45 Control-Unit.scala 79:23]
    node _GEN_29 = mux(_T_11, UInt<1>("h1"), _GEN_22) @[Control-Unit.scala 57:45 Control-Unit.scala 58:24]
    node _GEN_30 = mux(_T_11, UInt<1>("h0"), _GEN_23) @[Control-Unit.scala 57:45 Control-Unit.scala 59:22]
    node _GEN_31 = mux(_T_11, UInt<1>("h0"), _GEN_22) @[Control-Unit.scala 57:45 Control-Unit.scala 60:23]
    node _GEN_32 = mux(_T_11, UInt<1>("h0"), _GEN_24) @[Control-Unit.scala 57:45 Control-Unit.scala 61:24]
    node _GEN_33 = mux(_T_11, UInt<3>("h5"), _GEN_25) @[Control-Unit.scala 57:45 Control-Unit.scala 63:22]
    node _GEN_34 = mux(_T_11, UInt<1>("h0"), _GEN_26) @[Control-Unit.scala 57:45 Control-Unit.scala 64:19]
    node _GEN_35 = mux(_T_11, UInt<1>("h1"), _GEN_27) @[Control-Unit.scala 57:45 Control-Unit.scala 65:19]
    node _GEN_36 = mux(_T_11, UInt<2>("h2"), _GEN_27) @[Control-Unit.scala 57:45 Control-Unit.scala 66:26]
    node _GEN_37 = mux(_T_11, UInt<1>("h0"), _GEN_28) @[Control-Unit.scala 57:45 Control-Unit.scala 67:23]
    node _GEN_38 = mux(_T_10, UInt<1>("h0"), _GEN_29) @[Control-Unit.scala 45:45 Control-Unit.scala 46:24]
    node _GEN_39 = mux(_T_10, UInt<1>("h0"), _GEN_30) @[Control-Unit.scala 45:45 Control-Unit.scala 47:22]
    node _GEN_40 = mux(_T_10, UInt<1>("h0"), _GEN_31) @[Control-Unit.scala 45:45 Control-Unit.scala 48:23]
    node _GEN_41 = mux(_T_10, UInt<1>("h1"), _GEN_32) @[Control-Unit.scala 45:45 Control-Unit.scala 49:24]
    node _GEN_42 = mux(_T_10, UInt<1>("h1"), _GEN_33) @[Control-Unit.scala 45:45 Control-Unit.scala 51:22]
    node _GEN_43 = mux(_T_10, UInt<1>("h0"), _GEN_34) @[Control-Unit.scala 45:45 Control-Unit.scala 52:19]
    node _GEN_44 = mux(_T_10, UInt<1>("h1"), _GEN_35) @[Control-Unit.scala 45:45 Control-Unit.scala 53:19]
    node _GEN_45 = mux(_T_10, UInt<1>("h0"), _GEN_36) @[Control-Unit.scala 45:45 Control-Unit.scala 54:26]
    node _GEN_46 = mux(_T_10, UInt<1>("h0"), _GEN_37) @[Control-Unit.scala 45:45 Control-Unit.scala 55:23]
    node _GEN_47 = mux(_T_9, UInt<1>("h0"), _GEN_38) @[Control-Unit.scala 32:187 Control-Unit.scala 33:24]
    node _GEN_48 = mux(_T_9, UInt<1>("h0"), _GEN_39) @[Control-Unit.scala 32:187 Control-Unit.scala 34:22]
    node _GEN_49 = mux(_T_9, UInt<1>("h0"), _GEN_40) @[Control-Unit.scala 32:187 Control-Unit.scala 35:23]
    node _GEN_50 = mux(_T_9, UInt<1>("h0"), _GEN_41) @[Control-Unit.scala 32:187 Control-Unit.scala 36:24]
    node _GEN_51 = mux(_T_9, UInt<3>("h7"), _GEN_42) @[Control-Unit.scala 32:187 Control-Unit.scala 38:22]
    node _GEN_52 = mux(_T_9, UInt<1>("h0"), _GEN_43) @[Control-Unit.scala 32:187 Control-Unit.scala 39:19]
    node _GEN_53 = mux(_T_9, UInt<1>("h0"), _GEN_44) @[Control-Unit.scala 32:187 Control-Unit.scala 40:19]
    node _GEN_54 = mux(_T_9, UInt<1>("h0"), _GEN_45) @[Control-Unit.scala 32:187 Control-Unit.scala 41:26]
    node _GEN_55 = mux(_T_9, UInt<1>("h0"), _GEN_46) @[Control-Unit.scala 32:187 Control-Unit.scala 42:23]
    node _GEN_56 = mux(_T, UInt<1>("h0"), _GEN_47) @[Control-Unit.scala 20:40 Control-Unit.scala 21:24]
    node _GEN_57 = mux(_T, UInt<1>("h0"), _GEN_48) @[Control-Unit.scala 20:40 Control-Unit.scala 22:22]
    node _GEN_58 = mux(_T, UInt<1>("h1"), _GEN_49) @[Control-Unit.scala 20:40 Control-Unit.scala 23:23]
    node _GEN_59 = mux(_T, UInt<1>("h1"), _GEN_50) @[Control-Unit.scala 20:40 Control-Unit.scala 24:24]
    node _GEN_60 = mux(_T, UInt<3>("h4"), _GEN_51) @[Control-Unit.scala 20:40 Control-Unit.scala 26:22]
    node _GEN_61 = mux(_T, UInt<1>("h0"), _GEN_52) @[Control-Unit.scala 20:40 Control-Unit.scala 27:19]
    node _GEN_62 = mux(_T, UInt<1>("h1"), _GEN_53) @[Control-Unit.scala 20:40 Control-Unit.scala 28:19]
    node _GEN_63 = mux(_T, UInt<1>("h0"), _GEN_54) @[Control-Unit.scala 20:40 Control-Unit.scala 29:26]
    node _GEN_64 = mux(_T, UInt<1>("h0"), _GEN_55) @[Control-Unit.scala 20:40 Control-Unit.scala 30:23]
    io_CU_MemWrite <= _GEN_56
    io_CU_Branch <= _GEN_57
    io_CU_MemRead <= _GEN_58
    io_CU_RegWrite <= _GEN_59
    io_CU_MemToReg <= _GEN_58
    io_CU_ALU_op <= _GEN_60
    io_CU_InA <= _GEN_61
    io_CU_InB <= _GEN_62
    io_CU_Extend_sel <= _GEN_63
    io_CU_Next_PC <= _GEN_64

  module ALU :
    input clock : Clock
    input reset : UInt<1>
    input io_in_A : UInt<32>
    input io_in_B : UInt<32>
    input io_func3 : UInt<32>
    input io_alu_Op : UInt<4>
    output io_out : UInt<32>
    output io_sum : UInt<32>
    output io_CU_Branch_taken : UInt<1>

    node _sum_T = add(io_in_A, io_in_B) @[ALU.scala 56:23]
    node sum = tail(_sum_T, 1) @[ALU.scala 56:23]
    node _cmp_T = bits(io_in_A, 31, 31) @[ALU.scala 57:26]
    node _cmp_T_1 = bits(io_in_B, 31, 31) @[ALU.scala 57:46]
    node _cmp_T_2 = eq(_cmp_T, _cmp_T_1) @[ALU.scala 57:35]
    node _cmp_T_3 = bits(sum, 31, 31) @[ALU.scala 57:59]
    node _cmp_T_4 = bits(io_alu_Op, 1, 1) @[ALU.scala 58:30]
    node _cmp_T_5 = bits(io_in_B, 31, 31) @[ALU.scala 58:42]
    node _cmp_T_6 = bits(io_in_A, 31, 31) @[ALU.scala 58:59]
    node _cmp_T_7 = mux(_cmp_T_4, _cmp_T_5, _cmp_T_6) @[ALU.scala 58:20]
    node cmp = mux(_cmp_T_2, _cmp_T_3, _cmp_T_7) @[ALU.scala 57:18]
    node shamt = bits(io_in_B, 4, 0) @[ALU.scala 60:24]
    node _shin_T = bits(io_alu_Op, 3, 3) @[ALU.scala 61:29]
    node _shin_T_1 = shl(UInt<16>("hffff"), 16) @[Bitwise.scala 102:47]
    node _shin_T_2 = xor(UInt<32>("hffffffff"), _shin_T_1) @[Bitwise.scala 102:21]
    node _shin_T_3 = shr(io_in_A, 16) @[Bitwise.scala 103:21]
    node _shin_T_4 = and(_shin_T_3, _shin_T_2) @[Bitwise.scala 103:31]
    node _shin_T_5 = bits(io_in_A, 15, 0) @[Bitwise.scala 103:46]
    node _shin_T_6 = shl(_shin_T_5, 16) @[Bitwise.scala 103:65]
    node _shin_T_7 = not(_shin_T_2) @[Bitwise.scala 103:77]
    node _shin_T_8 = and(_shin_T_6, _shin_T_7) @[Bitwise.scala 103:75]
    node _shin_T_9 = or(_shin_T_4, _shin_T_8) @[Bitwise.scala 103:39]
    node _shin_T_10 = bits(_shin_T_2, 23, 0) @[Bitwise.scala 102:28]
    node _shin_T_11 = shl(_shin_T_10, 8) @[Bitwise.scala 102:47]
    node _shin_T_12 = xor(_shin_T_2, _shin_T_11) @[Bitwise.scala 102:21]
    node _shin_T_13 = shr(_shin_T_9, 8) @[Bitwise.scala 103:21]
    node _shin_T_14 = and(_shin_T_13, _shin_T_12) @[Bitwise.scala 103:31]
    node _shin_T_15 = bits(_shin_T_9, 23, 0) @[Bitwise.scala 103:46]
    node _shin_T_16 = shl(_shin_T_15, 8) @[Bitwise.scala 103:65]
    node _shin_T_17 = not(_shin_T_12) @[Bitwise.scala 103:77]
    node _shin_T_18 = and(_shin_T_16, _shin_T_17) @[Bitwise.scala 103:75]
    node _shin_T_19 = or(_shin_T_14, _shin_T_18) @[Bitwise.scala 103:39]
    node _shin_T_20 = bits(_shin_T_12, 27, 0) @[Bitwise.scala 102:28]
    node _shin_T_21 = shl(_shin_T_20, 4) @[Bitwise.scala 102:47]
    node _shin_T_22 = xor(_shin_T_12, _shin_T_21) @[Bitwise.scala 102:21]
    node _shin_T_23 = shr(_shin_T_19, 4) @[Bitwise.scala 103:21]
    node _shin_T_24 = and(_shin_T_23, _shin_T_22) @[Bitwise.scala 103:31]
    node _shin_T_25 = bits(_shin_T_19, 27, 0) @[Bitwise.scala 103:46]
    node _shin_T_26 = shl(_shin_T_25, 4) @[Bitwise.scala 103:65]
    node _shin_T_27 = not(_shin_T_22) @[Bitwise.scala 103:77]
    node _shin_T_28 = and(_shin_T_26, _shin_T_27) @[Bitwise.scala 103:75]
    node _shin_T_29 = or(_shin_T_24, _shin_T_28) @[Bitwise.scala 103:39]
    node _shin_T_30 = bits(_shin_T_22, 29, 0) @[Bitwise.scala 102:28]
    node _shin_T_31 = shl(_shin_T_30, 2) @[Bitwise.scala 102:47]
    node _shin_T_32 = xor(_shin_T_22, _shin_T_31) @[Bitwise.scala 102:21]
    node _shin_T_33 = shr(_shin_T_29, 2) @[Bitwise.scala 103:21]
    node _shin_T_34 = and(_shin_T_33, _shin_T_32) @[Bitwise.scala 103:31]
    node _shin_T_35 = bits(_shin_T_29, 29, 0) @[Bitwise.scala 103:46]
    node _shin_T_36 = shl(_shin_T_35, 2) @[Bitwise.scala 103:65]
    node _shin_T_37 = not(_shin_T_32) @[Bitwise.scala 103:77]
    node _shin_T_38 = and(_shin_T_36, _shin_T_37) @[Bitwise.scala 103:75]
    node _shin_T_39 = or(_shin_T_34, _shin_T_38) @[Bitwise.scala 103:39]
    node _shin_T_40 = bits(_shin_T_32, 30, 0) @[Bitwise.scala 102:28]
    node _shin_T_41 = shl(_shin_T_40, 1) @[Bitwise.scala 102:47]
    node _shin_T_42 = xor(_shin_T_32, _shin_T_41) @[Bitwise.scala 102:21]
    node _shin_T_43 = shr(_shin_T_39, 1) @[Bitwise.scala 103:21]
    node _shin_T_44 = and(_shin_T_43, _shin_T_42) @[Bitwise.scala 103:31]
    node _shin_T_45 = bits(_shin_T_39, 30, 0) @[Bitwise.scala 103:46]
    node _shin_T_46 = shl(_shin_T_45, 1) @[Bitwise.scala 103:65]
    node _shin_T_47 = not(_shin_T_42) @[Bitwise.scala 103:77]
    node _shin_T_48 = and(_shin_T_46, _shin_T_47) @[Bitwise.scala 103:75]
    node _shin_T_49 = or(_shin_T_44, _shin_T_48) @[Bitwise.scala 103:39]
    node shin = mux(_shin_T, io_in_A, _shin_T_49) @[ALU.scala 61:19]
    node _shiftr_T = bits(io_alu_Op, 0, 0) @[ALU.scala 62:32]
    node _shiftr_T_1 = bits(shin, 31, 31) @[ALU.scala 62:43]
    node shiftr_hi = and(_shiftr_T, _shiftr_T_1) @[ALU.scala 62:36]
    node _shiftr_T_2 = cat(shiftr_hi, shin) @[Cat.scala 30:58]
    node _shiftr_T_3 = asSInt(_shiftr_T_2) @[ALU.scala 62:59]
    node _shiftr_T_4 = dshr(_shiftr_T_3, shamt) @[ALU.scala 62:66]
    node shiftr = bits(_shiftr_T_4, 31, 0) @[ALU.scala 62:75]
    node _shitfl_T = shl(UInt<16>("hffff"), 16) @[Bitwise.scala 102:47]
    node _shitfl_T_1 = xor(UInt<32>("hffffffff"), _shitfl_T) @[Bitwise.scala 102:21]
    node _shitfl_T_2 = shr(shiftr, 16) @[Bitwise.scala 103:21]
    node _shitfl_T_3 = and(_shitfl_T_2, _shitfl_T_1) @[Bitwise.scala 103:31]
    node _shitfl_T_4 = bits(shiftr, 15, 0) @[Bitwise.scala 103:46]
    node _shitfl_T_5 = shl(_shitfl_T_4, 16) @[Bitwise.scala 103:65]
    node _shitfl_T_6 = not(_shitfl_T_1) @[Bitwise.scala 103:77]
    node _shitfl_T_7 = and(_shitfl_T_5, _shitfl_T_6) @[Bitwise.scala 103:75]
    node _shitfl_T_8 = or(_shitfl_T_3, _shitfl_T_7) @[Bitwise.scala 103:39]
    node _shitfl_T_9 = bits(_shitfl_T_1, 23, 0) @[Bitwise.scala 102:28]
    node _shitfl_T_10 = shl(_shitfl_T_9, 8) @[Bitwise.scala 102:47]
    node _shitfl_T_11 = xor(_shitfl_T_1, _shitfl_T_10) @[Bitwise.scala 102:21]
    node _shitfl_T_12 = shr(_shitfl_T_8, 8) @[Bitwise.scala 103:21]
    node _shitfl_T_13 = and(_shitfl_T_12, _shitfl_T_11) @[Bitwise.scala 103:31]
    node _shitfl_T_14 = bits(_shitfl_T_8, 23, 0) @[Bitwise.scala 103:46]
    node _shitfl_T_15 = shl(_shitfl_T_14, 8) @[Bitwise.scala 103:65]
    node _shitfl_T_16 = not(_shitfl_T_11) @[Bitwise.scala 103:77]
    node _shitfl_T_17 = and(_shitfl_T_15, _shitfl_T_16) @[Bitwise.scala 103:75]
    node _shitfl_T_18 = or(_shitfl_T_13, _shitfl_T_17) @[Bitwise.scala 103:39]
    node _shitfl_T_19 = bits(_shitfl_T_11, 27, 0) @[Bitwise.scala 102:28]
    node _shitfl_T_20 = shl(_shitfl_T_19, 4) @[Bitwise.scala 102:47]
    node _shitfl_T_21 = xor(_shitfl_T_11, _shitfl_T_20) @[Bitwise.scala 102:21]
    node _shitfl_T_22 = shr(_shitfl_T_18, 4) @[Bitwise.scala 103:21]
    node _shitfl_T_23 = and(_shitfl_T_22, _shitfl_T_21) @[Bitwise.scala 103:31]
    node _shitfl_T_24 = bits(_shitfl_T_18, 27, 0) @[Bitwise.scala 103:46]
    node _shitfl_T_25 = shl(_shitfl_T_24, 4) @[Bitwise.scala 103:65]
    node _shitfl_T_26 = not(_shitfl_T_21) @[Bitwise.scala 103:77]
    node _shitfl_T_27 = and(_shitfl_T_25, _shitfl_T_26) @[Bitwise.scala 103:75]
    node _shitfl_T_28 = or(_shitfl_T_23, _shitfl_T_27) @[Bitwise.scala 103:39]
    node _shitfl_T_29 = bits(_shitfl_T_21, 29, 0) @[Bitwise.scala 102:28]
    node _shitfl_T_30 = shl(_shitfl_T_29, 2) @[Bitwise.scala 102:47]
    node _shitfl_T_31 = xor(_shitfl_T_21, _shitfl_T_30) @[Bitwise.scala 102:21]
    node _shitfl_T_32 = shr(_shitfl_T_28, 2) @[Bitwise.scala 103:21]
    node _shitfl_T_33 = and(_shitfl_T_32, _shitfl_T_31) @[Bitwise.scala 103:31]
    node _shitfl_T_34 = bits(_shitfl_T_28, 29, 0) @[Bitwise.scala 103:46]
    node _shitfl_T_35 = shl(_shitfl_T_34, 2) @[Bitwise.scala 103:65]
    node _shitfl_T_36 = not(_shitfl_T_31) @[Bitwise.scala 103:77]
    node _shitfl_T_37 = and(_shitfl_T_35, _shitfl_T_36) @[Bitwise.scala 103:75]
    node _shitfl_T_38 = or(_shitfl_T_33, _shitfl_T_37) @[Bitwise.scala 103:39]
    node _shitfl_T_39 = bits(_shitfl_T_31, 30, 0) @[Bitwise.scala 102:28]
    node _shitfl_T_40 = shl(_shitfl_T_39, 1) @[Bitwise.scala 102:47]
    node _shitfl_T_41 = xor(_shitfl_T_31, _shitfl_T_40) @[Bitwise.scala 102:21]
    node _shitfl_T_42 = shr(_shitfl_T_38, 1) @[Bitwise.scala 103:21]
    node _shitfl_T_43 = and(_shitfl_T_42, _shitfl_T_41) @[Bitwise.scala 103:31]
    node _shitfl_T_44 = bits(_shitfl_T_38, 30, 0) @[Bitwise.scala 103:46]
    node _shitfl_T_45 = shl(_shitfl_T_44, 1) @[Bitwise.scala 103:65]
    node _shitfl_T_46 = not(_shitfl_T_41) @[Bitwise.scala 103:77]
    node _shitfl_T_47 = and(_shitfl_T_45, _shitfl_T_46) @[Bitwise.scala 103:75]
    node shitfl = or(_shitfl_T_43, _shitfl_T_47) @[Bitwise.scala 103:39]
    node _out_T = eq(io_alu_Op, UInt<4>("h0")) @[ALU.scala 65:19]
    node _out_T_1 = eq(io_alu_Op, UInt<4>("h1")) @[ALU.scala 65:44]
    node _out_T_2 = or(_out_T, _out_T_1) @[ALU.scala 65:31]
    node _out_T_3 = eq(io_alu_Op, UInt<4>("h5")) @[ALU.scala 66:19]
    node _out_T_4 = eq(io_alu_Op, UInt<4>("h7")) @[ALU.scala 66:44]
    node _out_T_5 = or(_out_T_3, _out_T_4) @[ALU.scala 66:31]
    node _out_T_6 = eq(io_alu_Op, UInt<4>("h9")) @[ALU.scala 67:19]
    node _out_T_7 = eq(io_alu_Op, UInt<4>("h8")) @[ALU.scala 67:44]
    node _out_T_8 = or(_out_T_6, _out_T_7) @[ALU.scala 67:31]
    node _out_T_9 = eq(io_alu_Op, UInt<4>("h6")) @[ALU.scala 68:19]
    node _out_T_10 = eq(io_alu_Op, UInt<4>("h2")) @[ALU.scala 69:19]
    node _out_T_11 = and(io_in_A, io_in_B) @[ALU.scala 69:41]
    node _out_T_12 = eq(io_alu_Op, UInt<4>("h3")) @[ALU.scala 70:19]
    node _out_T_13 = or(io_in_A, io_in_B) @[ALU.scala 70:40]
    node _out_T_14 = eq(io_alu_Op, UInt<4>("h4")) @[ALU.scala 71:19]
    node _out_T_15 = xor(io_in_A, io_in_B) @[ALU.scala 71:41]
    node _out_T_16 = eq(io_alu_Op, UInt<4>("ha")) @[ALU.scala 72:19]
    node _out_T_17 = eq(io_alu_Op, UInt<4>("hb")) @[ALU.scala 73:19]
    node _out_T_18 = mux(_out_T_17, io_in_B, UInt<1>("h0")) @[ALU.scala 73:8]
    node _out_T_19 = mux(_out_T_16, io_in_A, _out_T_18) @[ALU.scala 72:8]
    node _out_T_20 = mux(_out_T_14, _out_T_15, _out_T_19) @[ALU.scala 71:8]
    node _out_T_21 = mux(_out_T_12, _out_T_13, _out_T_20) @[ALU.scala 70:8]
    node _out_T_22 = mux(_out_T_10, _out_T_11, _out_T_21) @[ALU.scala 69:8]
    node _out_T_23 = mux(_out_T_9, shitfl, _out_T_22) @[ALU.scala 68:8]
    node _out_T_24 = mux(_out_T_8, shiftr, _out_T_23) @[ALU.scala 67:8]
    node _out_T_25 = mux(_out_T_5, cmp, _out_T_24) @[ALU.scala 66:8]
    node out = mux(_out_T_2, sum, _out_T_25) @[ALU.scala 65:8]
    io_out <= out @[ALU.scala 76:12]
    io_sum <= sum @[ALU.scala 77:12]
    io_CU_Branch_taken <= UInt<1>("h0") @[ALU.scala 118:22]

  module Data_Memory :
    input clock : Clock
    input reset : UInt<1>
    input io_Data_Mem_address : UInt<32>
    input io_Data_Mem_data : SInt<32>
    input io_Data_Mem_write : UInt<1>
    input io_Data_Mem_read : UInt<1>
    output io_Data_Mem_output : SInt<32>

    mem Memory : @[Data-Memory.scala 15:21]
      data-type => SInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_Data_Mem_output_MPORT
      writer => MPORT
      read-under-write => undefined
    node _T = bits(io_Data_Mem_address, 9, 0)
    node _GEN_0 = validif(io_Data_Mem_write, _T) @[Data-Memory.scala 17:28]
    node _GEN_1 = validif(io_Data_Mem_write, clock) @[Data-Memory.scala 17:28]
    node _GEN_2 = mux(io_Data_Mem_write, UInt<1>("h1"), UInt<1>("h0")) @[Data-Memory.scala 17:28 Data-Memory.scala 15:21]
    node _GEN_3 = validif(io_Data_Mem_write, UInt<1>("h1")) @[Data-Memory.scala 17:28]
    node _GEN_4 = validif(io_Data_Mem_write, io_Data_Mem_data) @[Data-Memory.scala 17:28]
    node _io_Data_Mem_output_T = bits(io_Data_Mem_address, 9, 0) @[Data-Memory.scala 21:42]
    node _GEN_5 = validif(io_Data_Mem_read, _io_Data_Mem_output_T) @[Data-Memory.scala 20:27 Data-Memory.scala 21:42]
    node _GEN_6 = validif(io_Data_Mem_read, clock) @[Data-Memory.scala 20:27 Data-Memory.scala 21:42]
    node _GEN_7 = mux(io_Data_Mem_read, UInt<1>("h1"), UInt<1>("h0")) @[Data-Memory.scala 20:27 Data-Memory.scala 21:42 Data-Memory.scala 15:21]
    node _GEN_8 = validif(io_Data_Mem_read, Memory.io_Data_Mem_output_MPORT.data) @[Data-Memory.scala 20:27 Data-Memory.scala 21:28]
    io_Data_Mem_output <= _GEN_8
    Memory.io_Data_Mem_output_MPORT.addr <= _GEN_5
    Memory.io_Data_Mem_output_MPORT.en <= _GEN_7
    Memory.io_Data_Mem_output_MPORT.clk <= _GEN_6
    Memory.MPORT.addr <= _GEN_0
    Memory.MPORT.en <= _GEN_2
    Memory.MPORT.clk <= _GEN_1
    Memory.MPORT.data <= _GEN_4
    Memory.MPORT.mask <= _GEN_3

  module ImmdValGen :
    input clock : Clock
    input reset : UInt<1>
    input io_Imm_pc : SInt<32>
    input io_Imm_instr : SInt<32>
    output io_immd_se_I : SInt<32>
    output io_immd_se_U : SInt<32>
    output io_immd_se_UJ : SInt<32>
    output io_immd_se_S : SInt<32>
    output io_immd_se_SB : SInt<32>

    node _T = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 21:18]
    node _T_1 = eq(_T, UInt<5>("h1b")) @[Immediate_Generation.scala 21:24]
    node _T_2 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 22:18]
    node _T_3 = eq(_T_2, UInt<2>("h3")) @[Immediate_Generation.scala 22:24]
    node _T_4 = or(_T_1, _T_3) @[Immediate_Generation.scala 21:42]
    node _T_5 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 23:18]
    node _T_6 = eq(_T_5, UInt<4>("hf")) @[Immediate_Generation.scala 23:24]
    node _T_7 = or(_T_4, _T_6) @[Immediate_Generation.scala 22:42]
    node _T_8 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 24:18]
    node _T_9 = eq(_T_8, UInt<5>("h1b")) @[Immediate_Generation.scala 24:24]
    node _T_10 = or(_T_7, _T_9) @[Immediate_Generation.scala 23:42]
    node _T_11 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 25:18]
    node _T_12 = eq(_T_11, UInt<7>("h67")) @[Immediate_Generation.scala 25:24]
    node _T_13 = or(_T_10, _T_12) @[Immediate_Generation.scala 24:42]
    node _T_14 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 26:18]
    node _T_15 = eq(_T_14, UInt<7>("h73")) @[Immediate_Generation.scala 26:24]
    node _T_16 = or(_T_13, _T_15) @[Immediate_Generation.scala 25:42]
    node _io_immd_se_I_T = bits(io_Imm_instr, 31, 20) @[Immediate_Generation.scala 30:38]
    node _io_immd_se_I_T_1 = asSInt(_io_immd_se_I_T) @[Immediate_Generation.scala 30:52]
    node _io_immd_se_I_T_2 = or(asSInt(UInt<1>("h0")), _io_immd_se_I_T_1) @[Immediate_Generation.scala 30:24]
    node _io_immd_se_I_T_3 = asSInt(_io_immd_se_I_T_2) @[Immediate_Generation.scala 30:24]
    node _T_17 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 37:18]
    node _T_18 = eq(_T_17, UInt<5>("h17")) @[Immediate_Generation.scala 37:24]
    node _T_19 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 38:18]
    node _T_20 = eq(_T_19, UInt<6>("h37")) @[Immediate_Generation.scala 38:24]
    node _T_21 = or(_T_18, _T_20) @[Immediate_Generation.scala 37:42]
    node _io_immd_se_U_T = bits(io_Imm_instr, 31, 12) @[Immediate_Generation.scala 42:37]
    node _io_immd_se_U_T_1 = asSInt(_io_immd_se_U_T) @[Immediate_Generation.scala 42:51]
    node _io_immd_se_U_T_2 = or(asSInt(UInt<1>("h0")), _io_immd_se_U_T_1) @[Immediate_Generation.scala 42:23]
    node _io_immd_se_U_T_3 = asSInt(_io_immd_se_U_T_2) @[Immediate_Generation.scala 42:23]
    node _T_22 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 49:18]
    node _T_23 = eq(_T_22, UInt<7>("h6f")) @[Immediate_Generation.scala 49:24]
    node io_immd_se_UJ_hi_hi_hi = bits(io_Imm_instr, 31, 31) @[Immediate_Generation.scala 53:40]
    node io_immd_se_UJ_hi_hi_lo = bits(io_Imm_instr, 19, 12) @[Immediate_Generation.scala 53:58]
    node io_immd_se_UJ_hi_lo = bits(io_Imm_instr, 20, 20) @[Immediate_Generation.scala 53:80]
    node io_immd_se_UJ_lo_hi = bits(io_Imm_instr, 30, 21) @[Immediate_Generation.scala 53:98]
    node io_immd_se_UJ_lo = cat(io_immd_se_UJ_lo_hi, UInt<1>("h0")) @[Cat.scala 30:58]
    node io_immd_se_UJ_hi_hi = cat(io_immd_se_UJ_hi_hi_hi, io_immd_se_UJ_hi_hi_lo) @[Cat.scala 30:58]
    node io_immd_se_UJ_hi = cat(io_immd_se_UJ_hi_hi, io_immd_se_UJ_hi_lo) @[Cat.scala 30:58]
    node _io_immd_se_UJ_T = cat(io_immd_se_UJ_hi, io_immd_se_UJ_lo) @[Cat.scala 30:58]
    node _io_immd_se_UJ_T_1 = asSInt(_io_immd_se_UJ_T) @[Immediate_Generation.scala 53:118]
    node _io_immd_se_UJ_T_2 = sub(asSInt(UInt<1>("h0")), _io_immd_se_UJ_T_1) @[Immediate_Generation.scala 53:22]
    node _io_immd_se_UJ_T_3 = tail(_io_immd_se_UJ_T_2, 1) @[Immediate_Generation.scala 53:22]
    node _io_immd_se_UJ_T_4 = asSInt(_io_immd_se_UJ_T_3) @[Immediate_Generation.scala 53:22]
    node _T_24 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 62:18]
    node _T_25 = eq(_T_24, UInt<6>("h23")) @[Immediate_Generation.scala 62:24]
    node _T_26 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 63:18]
    node _T_27 = eq(_T_26, UInt<7>("h63")) @[Immediate_Generation.scala 63:24]
    node _T_28 = or(_T_25, _T_27) @[Immediate_Generation.scala 62:42]
    node _io_immd_se_S_T = bits(io_Imm_instr, 31, 22) @[Immediate_Generation.scala 67:37]
    node _io_immd_se_S_T_1 = asSInt(_io_immd_se_S_T) @[Immediate_Generation.scala 67:51]
    node _io_immd_se_S_T_2 = or(asSInt(UInt<1>("h0")), _io_immd_se_S_T_1) @[Immediate_Generation.scala 67:23]
    node _io_immd_se_S_T_3 = asSInt(_io_immd_se_S_T_2) @[Immediate_Generation.scala 67:23]
    node _T_29 = bits(io_Imm_instr, 6, 0) @[Immediate_Generation.scala 75:18]
    node _T_30 = eq(_T_29, UInt<7>("h63")) @[Immediate_Generation.scala 75:24]
    node _io_immd_se_SB_T = bits(io_Imm_instr, 31, 22) @[Immediate_Generation.scala 79:38]
    node _io_immd_se_SB_T_1 = asSInt(_io_immd_se_SB_T) @[Immediate_Generation.scala 79:52]
    node _io_immd_se_SB_T_2 = or(asSInt(UInt<1>("h0")), _io_immd_se_SB_T_1) @[Immediate_Generation.scala 79:24]
    node _io_immd_se_SB_T_3 = asSInt(_io_immd_se_SB_T_2) @[Immediate_Generation.scala 79:24]
    node _GEN_0 = validif(_T_30, _io_immd_se_SB_T_3) @[Immediate_Generation.scala 78:3 Immediate_Generation.scala 79:18]
    node _GEN_1 = validif(_T_28, _io_immd_se_S_T_3) @[Immediate_Generation.scala 66:3 Immediate_Generation.scala 67:17]
    node _GEN_2 = validif(eq(_T_28, UInt<1>("h0")), _GEN_0) @[Immediate_Generation.scala 66:3]
    node _GEN_3 = validif(_T_23, _io_immd_se_UJ_T_4) @[Immediate_Generation.scala 52:3 Immediate_Generation.scala 53:19]
    node _GEN_4 = validif(eq(_T_23, UInt<1>("h0")), _GEN_1) @[Immediate_Generation.scala 52:3]
    node _GEN_5 = validif(eq(_T_23, UInt<1>("h0")), _GEN_2) @[Immediate_Generation.scala 52:3]
    node _GEN_6 = validif(_T_21, _io_immd_se_U_T_3) @[Immediate_Generation.scala 41:3 Immediate_Generation.scala 42:17]
    node _GEN_7 = validif(eq(_T_21, UInt<1>("h0")), _GEN_3) @[Immediate_Generation.scala 41:3]
    node _GEN_8 = validif(eq(_T_21, UInt<1>("h0")), _GEN_4) @[Immediate_Generation.scala 41:3]
    node _GEN_9 = validif(eq(_T_21, UInt<1>("h0")), _GEN_5) @[Immediate_Generation.scala 41:3]
    node _GEN_10 = validif(_T_16, _io_immd_se_I_T_3) @[Immediate_Generation.scala 29:3 Immediate_Generation.scala 30:17]
    node _GEN_11 = validif(eq(_T_16, UInt<1>("h0")), _GEN_6) @[Immediate_Generation.scala 29:3]
    node _GEN_12 = validif(eq(_T_16, UInt<1>("h0")), _GEN_7) @[Immediate_Generation.scala 29:3]
    node _GEN_13 = validif(eq(_T_16, UInt<1>("h0")), _GEN_8) @[Immediate_Generation.scala 29:3]
    node _GEN_14 = validif(eq(_T_16, UInt<1>("h0")), _GEN_9) @[Immediate_Generation.scala 29:3]
    io_immd_se_I <= _GEN_10
    io_immd_se_U <= _GEN_11
    io_immd_se_UJ <= _GEN_12
    io_immd_se_S <= _GEN_13
    io_immd_se_SB <= _GEN_14

  module PC :
    input clock : Clock
    input reset : UInt<1>
    input io_pc : SInt<32>
    output io_pc1 : SInt<32>
    output io_pc4 : SInt<32>

    reg pc_reg : SInt<32>, clock with :
      reset => (UInt<1>("h0"), pc_reg) @[Program-Counter.scala 17:25]
    node _io_pc4_T = add(pc_reg, asSInt(UInt<4>("h4"))) @[Program-Counter.scala 21:22]
    node _io_pc4_T_1 = tail(_io_pc4_T, 1) @[Program-Counter.scala 21:22]
    node _io_pc4_T_2 = asSInt(_io_pc4_T_1) @[Program-Counter.scala 21:22]
    io_pc1 <= pc_reg @[Program-Counter.scala 20:12]
    io_pc4 <= _io_pc4_T_2 @[Program-Counter.scala 21:12]
    pc_reg <= mux(reset, asSInt(UInt<32>("h0")), io_pc) @[Program-Counter.scala 17:25 Program-Counter.scala 17:25 Program-Counter.scala 18:12]

  module Jalr :
    input clock : Clock
    input reset : UInt<1>
    input io_rd : SInt<32>
    input io_rs1 : SInt<32>
    output io_imm : SInt<32>

    node _io_imm_T = add(io_rd, io_rs1) @[Jalr.scala 13:19]
    node _io_imm_T_1 = tail(_io_imm_T, 1) @[Jalr.scala 13:19]
    node _io_imm_T_2 = asSInt(_io_imm_T_1) @[Jalr.scala 13:19]
    node _io_imm_T_3 = and(_io_imm_T_2, asSInt(UInt<37>("hffffffffe"))) @[Jalr.scala 13:28]
    node _io_imm_T_4 = asSInt(_io_imm_T_3) @[Jalr.scala 13:28]
    io_imm <= asSInt(bits(_io_imm_T_4, 31, 0)) @[Jalr.scala 13:10]

  module Register_File :
    input clock : Clock
    input reset : UInt<1>
    input io_ReadReg1 : UInt<5>
    input io_ReadReg2 : UInt<5>
    input io_RegWrite : UInt<1>
    input io_WriteReg : UInt<5>
    input io_WriteData : SInt<32>
    output io_ReadData1 : SInt<32>
    output io_ReadData2 : SInt<32>

    reg Reg_File_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_0) @[Register-File.scala 16:27]
    reg Reg_File_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_1) @[Register-File.scala 16:27]
    reg Reg_File_2 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_2) @[Register-File.scala 16:27]
    reg Reg_File_3 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_3) @[Register-File.scala 16:27]
    reg Reg_File_4 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_4) @[Register-File.scala 16:27]
    reg Reg_File_5 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_5) @[Register-File.scala 16:27]
    reg Reg_File_6 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_6) @[Register-File.scala 16:27]
    reg Reg_File_7 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_7) @[Register-File.scala 16:27]
    reg Reg_File_8 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_8) @[Register-File.scala 16:27]
    reg Reg_File_9 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_9) @[Register-File.scala 16:27]
    reg Reg_File_10 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_10) @[Register-File.scala 16:27]
    reg Reg_File_11 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_11) @[Register-File.scala 16:27]
    reg Reg_File_12 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_12) @[Register-File.scala 16:27]
    reg Reg_File_13 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_13) @[Register-File.scala 16:27]
    reg Reg_File_14 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_14) @[Register-File.scala 16:27]
    reg Reg_File_15 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_15) @[Register-File.scala 16:27]
    reg Reg_File_16 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_16) @[Register-File.scala 16:27]
    reg Reg_File_17 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_17) @[Register-File.scala 16:27]
    reg Reg_File_18 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_18) @[Register-File.scala 16:27]
    reg Reg_File_19 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_19) @[Register-File.scala 16:27]
    reg Reg_File_20 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_20) @[Register-File.scala 16:27]
    reg Reg_File_21 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_21) @[Register-File.scala 16:27]
    reg Reg_File_22 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_22) @[Register-File.scala 16:27]
    reg Reg_File_23 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_23) @[Register-File.scala 16:27]
    reg Reg_File_24 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_24) @[Register-File.scala 16:27]
    reg Reg_File_25 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_25) @[Register-File.scala 16:27]
    reg Reg_File_26 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_26) @[Register-File.scala 16:27]
    reg Reg_File_27 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_27) @[Register-File.scala 16:27]
    reg Reg_File_28 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_28) @[Register-File.scala 16:27]
    reg Reg_File_29 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_29) @[Register-File.scala 16:27]
    reg Reg_File_30 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_30) @[Register-File.scala 16:27]
    reg Reg_File_31 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_File_31) @[Register-File.scala 16:27]
    node _GEN_0 = validif(eq(UInt<1>("h0"), io_ReadReg1), Reg_File_0) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_ReadReg1), Reg_File_1, _GEN_0) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_2 = mux(eq(UInt<2>("h2"), io_ReadReg1), Reg_File_2, _GEN_1) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_3 = mux(eq(UInt<2>("h3"), io_ReadReg1), Reg_File_3, _GEN_2) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_4 = mux(eq(UInt<3>("h4"), io_ReadReg1), Reg_File_4, _GEN_3) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_5 = mux(eq(UInt<3>("h5"), io_ReadReg1), Reg_File_5, _GEN_4) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_6 = mux(eq(UInt<3>("h6"), io_ReadReg1), Reg_File_6, _GEN_5) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_7 = mux(eq(UInt<3>("h7"), io_ReadReg1), Reg_File_7, _GEN_6) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_8 = mux(eq(UInt<4>("h8"), io_ReadReg1), Reg_File_8, _GEN_7) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_9 = mux(eq(UInt<4>("h9"), io_ReadReg1), Reg_File_9, _GEN_8) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_10 = mux(eq(UInt<4>("ha"), io_ReadReg1), Reg_File_10, _GEN_9) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_11 = mux(eq(UInt<4>("hb"), io_ReadReg1), Reg_File_11, _GEN_10) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_12 = mux(eq(UInt<4>("hc"), io_ReadReg1), Reg_File_12, _GEN_11) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_13 = mux(eq(UInt<4>("hd"), io_ReadReg1), Reg_File_13, _GEN_12) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_14 = mux(eq(UInt<4>("he"), io_ReadReg1), Reg_File_14, _GEN_13) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_15 = mux(eq(UInt<4>("hf"), io_ReadReg1), Reg_File_15, _GEN_14) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_16 = mux(eq(UInt<5>("h10"), io_ReadReg1), Reg_File_16, _GEN_15) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_17 = mux(eq(UInt<5>("h11"), io_ReadReg1), Reg_File_17, _GEN_16) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_18 = mux(eq(UInt<5>("h12"), io_ReadReg1), Reg_File_18, _GEN_17) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_19 = mux(eq(UInt<5>("h13"), io_ReadReg1), Reg_File_19, _GEN_18) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_20 = mux(eq(UInt<5>("h14"), io_ReadReg1), Reg_File_20, _GEN_19) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_21 = mux(eq(UInt<5>("h15"), io_ReadReg1), Reg_File_21, _GEN_20) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_22 = mux(eq(UInt<5>("h16"), io_ReadReg1), Reg_File_22, _GEN_21) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_23 = mux(eq(UInt<5>("h17"), io_ReadReg1), Reg_File_23, _GEN_22) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_24 = mux(eq(UInt<5>("h18"), io_ReadReg1), Reg_File_24, _GEN_23) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_25 = mux(eq(UInt<5>("h19"), io_ReadReg1), Reg_File_25, _GEN_24) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_26 = mux(eq(UInt<5>("h1a"), io_ReadReg1), Reg_File_26, _GEN_25) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_27 = mux(eq(UInt<5>("h1b"), io_ReadReg1), Reg_File_27, _GEN_26) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_28 = mux(eq(UInt<5>("h1c"), io_ReadReg1), Reg_File_28, _GEN_27) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_29 = mux(eq(UInt<5>("h1d"), io_ReadReg1), Reg_File_29, _GEN_28) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_30 = mux(eq(UInt<5>("h1e"), io_ReadReg1), Reg_File_30, _GEN_29) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_31 = mux(eq(UInt<5>("h1f"), io_ReadReg1), Reg_File_31, _GEN_30) @[Register-File.scala 19:18 Register-File.scala 19:18]
    node _GEN_32 = validif(eq(UInt<1>("h0"), io_ReadReg2), Reg_File_0) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_33 = mux(eq(UInt<1>("h1"), io_ReadReg2), Reg_File_1, _GEN_32) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_34 = mux(eq(UInt<2>("h2"), io_ReadReg2), Reg_File_2, _GEN_33) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_35 = mux(eq(UInt<2>("h3"), io_ReadReg2), Reg_File_3, _GEN_34) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_36 = mux(eq(UInt<3>("h4"), io_ReadReg2), Reg_File_4, _GEN_35) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_37 = mux(eq(UInt<3>("h5"), io_ReadReg2), Reg_File_5, _GEN_36) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_38 = mux(eq(UInt<3>("h6"), io_ReadReg2), Reg_File_6, _GEN_37) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_39 = mux(eq(UInt<3>("h7"), io_ReadReg2), Reg_File_7, _GEN_38) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_40 = mux(eq(UInt<4>("h8"), io_ReadReg2), Reg_File_8, _GEN_39) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_41 = mux(eq(UInt<4>("h9"), io_ReadReg2), Reg_File_9, _GEN_40) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_42 = mux(eq(UInt<4>("ha"), io_ReadReg2), Reg_File_10, _GEN_41) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_43 = mux(eq(UInt<4>("hb"), io_ReadReg2), Reg_File_11, _GEN_42) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_44 = mux(eq(UInt<4>("hc"), io_ReadReg2), Reg_File_12, _GEN_43) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_45 = mux(eq(UInt<4>("hd"), io_ReadReg2), Reg_File_13, _GEN_44) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_46 = mux(eq(UInt<4>("he"), io_ReadReg2), Reg_File_14, _GEN_45) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_47 = mux(eq(UInt<4>("hf"), io_ReadReg2), Reg_File_15, _GEN_46) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_48 = mux(eq(UInt<5>("h10"), io_ReadReg2), Reg_File_16, _GEN_47) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_49 = mux(eq(UInt<5>("h11"), io_ReadReg2), Reg_File_17, _GEN_48) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_50 = mux(eq(UInt<5>("h12"), io_ReadReg2), Reg_File_18, _GEN_49) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_51 = mux(eq(UInt<5>("h13"), io_ReadReg2), Reg_File_19, _GEN_50) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_52 = mux(eq(UInt<5>("h14"), io_ReadReg2), Reg_File_20, _GEN_51) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_53 = mux(eq(UInt<5>("h15"), io_ReadReg2), Reg_File_21, _GEN_52) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_54 = mux(eq(UInt<5>("h16"), io_ReadReg2), Reg_File_22, _GEN_53) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_55 = mux(eq(UInt<5>("h17"), io_ReadReg2), Reg_File_23, _GEN_54) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_56 = mux(eq(UInt<5>("h18"), io_ReadReg2), Reg_File_24, _GEN_55) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_57 = mux(eq(UInt<5>("h19"), io_ReadReg2), Reg_File_25, _GEN_56) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_58 = mux(eq(UInt<5>("h1a"), io_ReadReg2), Reg_File_26, _GEN_57) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_59 = mux(eq(UInt<5>("h1b"), io_ReadReg2), Reg_File_27, _GEN_58) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_60 = mux(eq(UInt<5>("h1c"), io_ReadReg2), Reg_File_28, _GEN_59) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_61 = mux(eq(UInt<5>("h1d"), io_ReadReg2), Reg_File_29, _GEN_60) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_62 = mux(eq(UInt<5>("h1e"), io_ReadReg2), Reg_File_30, _GEN_61) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _GEN_63 = mux(eq(UInt<5>("h1f"), io_ReadReg2), Reg_File_31, _GEN_62) @[Register-File.scala 20:18 Register-File.scala 20:18]
    node _Reg_File_io_WriteReg = io_WriteData @[Register-File.scala 23:31 Register-File.scala 23:31]
    node _GEN_64 = mux(eq(UInt<1>("h0"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_0) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_65 = mux(eq(UInt<1>("h1"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_1) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_66 = mux(eq(UInt<2>("h2"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_2) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_67 = mux(eq(UInt<2>("h3"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_3) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_68 = mux(eq(UInt<3>("h4"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_4) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_69 = mux(eq(UInt<3>("h5"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_5) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_70 = mux(eq(UInt<3>("h6"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_6) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_71 = mux(eq(UInt<3>("h7"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_7) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_72 = mux(eq(UInt<4>("h8"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_8) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_73 = mux(eq(UInt<4>("h9"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_9) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_74 = mux(eq(UInt<4>("ha"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_10) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_75 = mux(eq(UInt<4>("hb"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_11) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_76 = mux(eq(UInt<4>("hc"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_12) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_77 = mux(eq(UInt<4>("hd"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_13) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_78 = mux(eq(UInt<4>("he"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_14) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_79 = mux(eq(UInt<4>("hf"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_15) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_80 = mux(eq(UInt<5>("h10"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_16) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_81 = mux(eq(UInt<5>("h11"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_17) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_82 = mux(eq(UInt<5>("h12"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_18) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_83 = mux(eq(UInt<5>("h13"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_19) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_84 = mux(eq(UInt<5>("h14"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_20) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_85 = mux(eq(UInt<5>("h15"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_21) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_86 = mux(eq(UInt<5>("h16"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_22) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_87 = mux(eq(UInt<5>("h17"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_23) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_88 = mux(eq(UInt<5>("h18"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_24) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_89 = mux(eq(UInt<5>("h19"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_25) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_90 = mux(eq(UInt<5>("h1a"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_26) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_91 = mux(eq(UInt<5>("h1b"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_27) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_92 = mux(eq(UInt<5>("h1c"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_28) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_93 = mux(eq(UInt<5>("h1d"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_29) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_94 = mux(eq(UInt<5>("h1e"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_30) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_95 = mux(eq(UInt<5>("h1f"), io_WriteReg), _Reg_File_io_WriteReg, Reg_File_31) @[Register-File.scala 23:31 Register-File.scala 23:31 Register-File.scala 16:27]
    node _GEN_96 = mux(io_RegWrite, _GEN_64, Reg_File_0) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_97 = mux(io_RegWrite, _GEN_65, Reg_File_1) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_98 = mux(io_RegWrite, _GEN_66, Reg_File_2) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_99 = mux(io_RegWrite, _GEN_67, Reg_File_3) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_100 = mux(io_RegWrite, _GEN_68, Reg_File_4) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_101 = mux(io_RegWrite, _GEN_69, Reg_File_5) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_102 = mux(io_RegWrite, _GEN_70, Reg_File_6) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_103 = mux(io_RegWrite, _GEN_71, Reg_File_7) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_104 = mux(io_RegWrite, _GEN_72, Reg_File_8) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_105 = mux(io_RegWrite, _GEN_73, Reg_File_9) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_106 = mux(io_RegWrite, _GEN_74, Reg_File_10) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_107 = mux(io_RegWrite, _GEN_75, Reg_File_11) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_108 = mux(io_RegWrite, _GEN_76, Reg_File_12) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_109 = mux(io_RegWrite, _GEN_77, Reg_File_13) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_110 = mux(io_RegWrite, _GEN_78, Reg_File_14) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_111 = mux(io_RegWrite, _GEN_79, Reg_File_15) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_112 = mux(io_RegWrite, _GEN_80, Reg_File_16) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_113 = mux(io_RegWrite, _GEN_81, Reg_File_17) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_114 = mux(io_RegWrite, _GEN_82, Reg_File_18) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_115 = mux(io_RegWrite, _GEN_83, Reg_File_19) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_116 = mux(io_RegWrite, _GEN_84, Reg_File_20) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_117 = mux(io_RegWrite, _GEN_85, Reg_File_21) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_118 = mux(io_RegWrite, _GEN_86, Reg_File_22) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_119 = mux(io_RegWrite, _GEN_87, Reg_File_23) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_120 = mux(io_RegWrite, _GEN_88, Reg_File_24) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_121 = mux(io_RegWrite, _GEN_89, Reg_File_25) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_122 = mux(io_RegWrite, _GEN_90, Reg_File_26) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_123 = mux(io_RegWrite, _GEN_91, Reg_File_27) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_124 = mux(io_RegWrite, _GEN_92, Reg_File_28) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_125 = mux(io_RegWrite, _GEN_93, Reg_File_29) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_126 = mux(io_RegWrite, _GEN_94, Reg_File_30) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _GEN_127 = mux(io_RegWrite, _GEN_95, Reg_File_31) @[Register-File.scala 22:22 Register-File.scala 16:27]
    node _Reg_File_WIRE_0 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_1 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_2 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_3 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_4 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_5 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_6 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_7 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_8 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_9 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_10 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_11 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_12 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_13 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_14 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_15 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_16 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_17 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_18 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_19 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_20 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_21 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_22 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_23 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_24 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_25 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_26 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_27 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_28 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_29 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_30 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_WIRE_31 = asSInt(UInt<32>("h0")) @[Register-File.scala 16:35 Register-File.scala 16:35]
    node _Reg_File_io_ReadReg1 = _GEN_31 @[Register-File.scala 19:18]
    node _Reg_File_io_ReadReg2 = _GEN_63 @[Register-File.scala 20:18]
    io_ReadData1 <= _Reg_File_io_ReadReg1 @[Register-File.scala 19:18]
    io_ReadData2 <= _Reg_File_io_ReadReg2 @[Register-File.scala 20:18]
    Reg_File_0 <= mux(reset, _Reg_File_WIRE_0, asSInt(UInt<1>("h0"))) @[Register-File.scala 16:27 Register-File.scala 16:27 Register-File.scala 25:17]
    Reg_File_1 <= mux(reset, _Reg_File_WIRE_1, _GEN_97) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_2 <= mux(reset, _Reg_File_WIRE_2, _GEN_98) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_3 <= mux(reset, _Reg_File_WIRE_3, _GEN_99) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_4 <= mux(reset, _Reg_File_WIRE_4, _GEN_100) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_5 <= mux(reset, _Reg_File_WIRE_5, _GEN_101) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_6 <= mux(reset, _Reg_File_WIRE_6, _GEN_102) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_7 <= mux(reset, _Reg_File_WIRE_7, _GEN_103) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_8 <= mux(reset, _Reg_File_WIRE_8, _GEN_104) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_9 <= mux(reset, _Reg_File_WIRE_9, _GEN_105) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_10 <= mux(reset, _Reg_File_WIRE_10, _GEN_106) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_11 <= mux(reset, _Reg_File_WIRE_11, _GEN_107) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_12 <= mux(reset, _Reg_File_WIRE_12, _GEN_108) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_13 <= mux(reset, _Reg_File_WIRE_13, _GEN_109) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_14 <= mux(reset, _Reg_File_WIRE_14, _GEN_110) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_15 <= mux(reset, _Reg_File_WIRE_15, _GEN_111) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_16 <= mux(reset, _Reg_File_WIRE_16, _GEN_112) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_17 <= mux(reset, _Reg_File_WIRE_17, _GEN_113) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_18 <= mux(reset, _Reg_File_WIRE_18, _GEN_114) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_19 <= mux(reset, _Reg_File_WIRE_19, _GEN_115) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_20 <= mux(reset, _Reg_File_WIRE_20, _GEN_116) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_21 <= mux(reset, _Reg_File_WIRE_21, _GEN_117) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_22 <= mux(reset, _Reg_File_WIRE_22, _GEN_118) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_23 <= mux(reset, _Reg_File_WIRE_23, _GEN_119) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_24 <= mux(reset, _Reg_File_WIRE_24, _GEN_120) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_25 <= mux(reset, _Reg_File_WIRE_25, _GEN_121) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_26 <= mux(reset, _Reg_File_WIRE_26, _GEN_122) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_27 <= mux(reset, _Reg_File_WIRE_27, _GEN_123) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_28 <= mux(reset, _Reg_File_WIRE_28, _GEN_124) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_29 <= mux(reset, _Reg_File_WIRE_29, _GEN_125) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_30 <= mux(reset, _Reg_File_WIRE_30, _GEN_126) @[Register-File.scala 16:27 Register-File.scala 16:27]
    Reg_File_31 <= mux(reset, _Reg_File_WIRE_31, _GEN_127) @[Register-File.scala 16:27 Register-File.scala 16:27]

  module ALU_Branch_Control :
    input clock : Clock
    input reset : UInt<1>
    input io_fnct3 : UInt<3>
    input io_CU_Branch : UInt<1>
    input io_CU_Branch_alu_inx : UInt<32>
    input io_CU_Branch_alu_iny : UInt<32>
    output io_CU_Branch_taken : UInt<1>

    node _T = eq(UInt<3>("h0"), io_fnct3) @[Conditional.scala 37:30]
    node _io_CU_Branch_taken_T = eq(io_CU_Branch_alu_inx, io_CU_Branch_alu_iny) @[ALU_Branch_Control.scala 37:52]
    node _T_1 = eq(UInt<3>("h1"), io_fnct3) @[Conditional.scala 37:30]
    node _io_CU_Branch_taken_T_1 = neq(io_CU_Branch_alu_inx, io_CU_Branch_alu_iny) @[ALU_Branch_Control.scala 40:52]
    node _T_2 = eq(UInt<3>("h4"), io_fnct3) @[Conditional.scala 37:30]
    node _io_CU_Branch_taken_T_2 = lt(io_CU_Branch_alu_inx, io_CU_Branch_alu_iny) @[ALU_Branch_Control.scala 43:52]
    node _T_3 = eq(UInt<3>("h5"), io_fnct3) @[Conditional.scala 37:30]
    node _io_CU_Branch_taken_T_3 = geq(io_CU_Branch_alu_inx, io_CU_Branch_alu_iny) @[ALU_Branch_Control.scala 46:52]
    node _T_4 = eq(UInt<3>("h6"), io_fnct3) @[Conditional.scala 37:30]
    node _io_CU_Branch_taken_T_4 = leq(io_CU_Branch_alu_inx, io_CU_Branch_alu_iny) @[ALU_Branch_Control.scala 49:52]
    node _T_5 = eq(UInt<3>("h7"), io_fnct3) @[Conditional.scala 37:30]
    node _io_CU_Branch_taken_T_5 = gt(io_CU_Branch_alu_inx, io_CU_Branch_alu_iny) @[ALU_Branch_Control.scala 52:52]
    node _T_6 = eq(UInt<3>("h2"), io_fnct3) @[Conditional.scala 37:30]
    node _io_CU_Branch_taken_T_6 = leq(io_CU_Branch_alu_inx, io_CU_Branch_alu_iny) @[ALU_Branch_Control.scala 55:52]
    node _GEN_0 = mux(_T_6, _io_CU_Branch_taken_T_6, UInt<1>("h0")) @[Conditional.scala 39:67 ALU_Branch_Control.scala 55:28 ALU_Branch_Control.scala 32:22]
    node _GEN_1 = mux(_T_5, _io_CU_Branch_taken_T_5, _GEN_0) @[Conditional.scala 39:67 ALU_Branch_Control.scala 52:28]
    node _GEN_2 = mux(_T_4, _io_CU_Branch_taken_T_4, _GEN_1) @[Conditional.scala 39:67 ALU_Branch_Control.scala 49:28]
    node _GEN_3 = mux(_T_3, _io_CU_Branch_taken_T_3, _GEN_2) @[Conditional.scala 39:67 ALU_Branch_Control.scala 46:28]
    node _GEN_4 = mux(_T_2, _io_CU_Branch_taken_T_2, _GEN_3) @[Conditional.scala 39:67 ALU_Branch_Control.scala 43:28]
    node _GEN_5 = mux(_T_1, _io_CU_Branch_taken_T_1, _GEN_4) @[Conditional.scala 39:67 ALU_Branch_Control.scala 40:28]
    node _GEN_6 = mux(_T, _io_CU_Branch_taken_T, _GEN_5) @[Conditional.scala 40:58 ALU_Branch_Control.scala 37:28]
    node _GEN_7 = mux(io_CU_Branch, _GEN_6, UInt<1>("h0")) @[ALU_Branch_Control.scala 34:22 ALU_Branch_Control.scala 32:22]
    io_CU_Branch_taken <= _GEN_7

  module IF_ID :
    input clock : Clock
    input reset : UInt<1>
    input io_pc_in : SInt<32>
    output io_pc_out : SInt<32>
    input io_pc_in4 : SInt<32>
    output io_pc_out4 : SInt<32>
    input io_instr_in : UInt<32>
    output io_instr_out : UInt<32>

    reg RegPC : SInt<32>, clock with :
      reset => (UInt<1>("h0"), RegPC) @[IF_ID.scala 19:24]
    reg RegPC4 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), RegPC4) @[IF_ID.scala 20:25]
    reg RegINSTR : UInt<32>, clock with :
      reset => (UInt<1>("h0"), RegINSTR) @[IF_ID.scala 21:27]
    io_pc_out <= RegPC @[IF_ID.scala 29:15]
    io_pc_out4 <= RegPC4 @[IF_ID.scala 30:16]
    io_instr_out <= RegINSTR @[IF_ID.scala 31:18]
    RegPC <= mux(reset, asSInt(UInt<32>("h0")), io_pc_in) @[IF_ID.scala 19:24 IF_ID.scala 19:24 IF_ID.scala 24:11]
    RegPC4 <= mux(reset, asSInt(UInt<32>("h0")), io_pc_in4) @[IF_ID.scala 20:25 IF_ID.scala 20:25 IF_ID.scala 25:12]
    RegINSTR <= mux(reset, UInt<32>("h0"), io_instr_in) @[IF_ID.scala 21:27 IF_ID.scala 21:27 IF_ID.scala 26:14]

  module ID_EX :
    input clock : Clock
    input reset : UInt<1>
    input io_IF_ID_pc : SInt<32>
    output io_pc_out : SInt<32>
    input io_rs1_sel_in : UInt<5>
    output io_rs1_sel_out : UInt<5>
    input io_rs2_sel_in : UInt<5>
    output io_rs2_sel_out : UInt<5>
    input io_rs1_in : UInt<32>
    output io_rs1_out : UInt<32>
    input io_rs2_in : UInt<32>
    output io_rs2_out : UInt<32>
    input io_imm : UInt<32>
    output io_imm_out : UInt<32>
    input io_rd_sel_in : UInt<5>
    output io_rd_sel_out : UInt<5>
    input io_func3_in : UInt<3>
    output io_func3_out : UInt<3>
    input io_func7_in : UInt<7>
    output io_func7_out : UInt<7>
    input io_ctrl_MemWr_in : UInt<1>
    output io_ctrl_MemWr_out : UInt<1>
    input io_ctrl_MemRd_in : UInt<1>
    output io_ctrl_MemRd_out : UInt<1>
    input io_ctrl_Branch_in : UInt<1>
    output io_ctrl_Branch_out : UInt<1>
    input io_ctrl_RegWr_in : UInt<1>
    output io_ctrl_RegWr_out : UInt<1>
    input io_ctrl_MemtoReg_in : UInt<1>
    output io_ctrl_MemtoReg_out : UInt<1>
    input io_ctrl_ALUOP_in : UInt<4>
    output io_ctrl_ALUOP_out : UInt<4>
    input io_ctrl_OpA_sel_in : UInt<1>
    output io_ctrl_OpA_sel_out : UInt<1>
    input io_ctrl_OpB_sel_in : UInt<1>
    output io_ctrl_OpB_sel_out : UInt<1>
    input io_ctrl_nextPc_sel_in : UInt<2>
    output io_ctrl_nextPc_sel_out : UInt<2>

    reg RegID_EX_PC : SInt<32>, clock with :
      reset => (UInt<1>("h0"), RegID_EX_PC) @[ID_EX.scala 66:28]
    reg Regrs1_sel : UInt<5>, clock with :
      reset => (UInt<1>("h0"), Regrs1_sel) @[ID_EX.scala 67:27]
    reg Regrs2_sel : UInt<5>, clock with :
      reset => (UInt<1>("h0"), Regrs2_sel) @[ID_EX.scala 68:27]
    reg Regrs1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), Regrs1) @[ID_EX.scala 69:23]
    reg Regrs2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), Regrs2) @[ID_EX.scala 70:23]
    reg Regimm : UInt<32>, clock with :
      reset => (UInt<1>("h0"), Regimm) @[ID_EX.scala 71:23]
    reg Regrd_sel : UInt<5>, clock with :
      reset => (UInt<1>("h0"), Regrd_sel) @[ID_EX.scala 72:26]
    reg Regfunc3 : UInt<3>, clock with :
      reset => (UInt<1>("h0"), Regfunc3) @[ID_EX.scala 73:25]
    reg Regfunc7 : UInt<7>, clock with :
      reset => (UInt<1>("h0"), Regfunc7) @[ID_EX.scala 74:25]
    reg Reg_Ctrl_MemWr : UInt<1>, clock with :
      reset => (UInt<1>("h0"), Reg_Ctrl_MemWr) @[ID_EX.scala 75:31]
    reg Reg_Ctrl_MemRd : UInt<1>, clock with :
      reset => (UInt<1>("h0"), Reg_Ctrl_MemRd) @[ID_EX.scala 76:31]
    reg Reg_Ctrl_Branch : UInt<1>, clock with :
      reset => (UInt<1>("h0"), Reg_Ctrl_Branch) @[ID_EX.scala 77:32]
    reg Reg_Ctrl_RegWr : UInt<1>, clock with :
      reset => (UInt<1>("h0"), Reg_Ctrl_RegWr) @[ID_EX.scala 78:31]
    reg Reg_Ctrl_MemtoReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), Reg_Ctrl_MemtoReg) @[ID_EX.scala 79:34]
    reg Reg_Ctrl_AluOp : UInt<4>, clock with :
      reset => (UInt<1>("h0"), Reg_Ctrl_AluOp) @[ID_EX.scala 80:31]
    reg Reg_Ctrl_OpA : UInt<1>, clock with :
      reset => (UInt<1>("h0"), Reg_Ctrl_OpA) @[ID_EX.scala 81:29]
    reg Reg_Ctrl_OpB : UInt<1>, clock with :
      reset => (UInt<1>("h0"), Reg_Ctrl_OpB) @[ID_EX.scala 82:29]
    reg Reg_Ctrl_nextPc : UInt<2>, clock with :
      reset => (UInt<1>("h0"), Reg_Ctrl_nextPc) @[ID_EX.scala 83:32]
    io_pc_out <= RegID_EX_PC @[ID_EX.scala 106:13]
    io_rs1_sel_out <= Regrs1_sel @[ID_EX.scala 107:18]
    io_rs2_sel_out <= Regrs2_sel @[ID_EX.scala 108:18]
    io_rs1_out <= Regrs1 @[ID_EX.scala 109:14]
    io_rs2_out <= Regrs2 @[ID_EX.scala 110:14]
    io_imm_out <= Regimm @[ID_EX.scala 111:14]
    io_rd_sel_out <= Regrd_sel @[ID_EX.scala 112:17]
    io_func3_out <= Regfunc3 @[ID_EX.scala 113:16]
    io_func7_out <= Regfunc7 @[ID_EX.scala 114:16]
    io_ctrl_MemWr_out <= Reg_Ctrl_MemWr @[ID_EX.scala 115:21]
    io_ctrl_MemRd_out <= Reg_Ctrl_MemRd @[ID_EX.scala 116:21]
    io_ctrl_Branch_out <= Reg_Ctrl_Branch @[ID_EX.scala 117:22]
    io_ctrl_RegWr_out <= Reg_Ctrl_RegWr @[ID_EX.scala 118:21]
    io_ctrl_MemtoReg_out <= Reg_Ctrl_MemtoReg @[ID_EX.scala 119:24]
    io_ctrl_ALUOP_out <= Reg_Ctrl_AluOp @[ID_EX.scala 120:21]
    io_ctrl_OpA_sel_out <= Reg_Ctrl_OpA @[ID_EX.scala 121:23]
    io_ctrl_OpB_sel_out <= Reg_Ctrl_OpB @[ID_EX.scala 122:23]
    io_ctrl_nextPc_sel_out <= Reg_Ctrl_nextPc @[ID_EX.scala 123:26]
    RegID_EX_PC <= mux(reset, asSInt(UInt<32>("h0")), io_IF_ID_pc) @[ID_EX.scala 66:28 ID_EX.scala 66:28 ID_EX.scala 86:15]
    Regrs1_sel <= mux(reset, UInt<5>("h0"), io_rs1_sel_in) @[ID_EX.scala 67:27 ID_EX.scala 67:27 ID_EX.scala 87:14]
    Regrs2_sel <= mux(reset, UInt<5>("h0"), io_rs2_sel_in) @[ID_EX.scala 68:27 ID_EX.scala 68:27 ID_EX.scala 88:14]
    Regrs1 <= mux(reset, UInt<32>("h0"), io_rs1_in) @[ID_EX.scala 69:23 ID_EX.scala 69:23 ID_EX.scala 89:10]
    Regrs2 <= mux(reset, UInt<32>("h0"), io_rs2_in) @[ID_EX.scala 70:23 ID_EX.scala 70:23 ID_EX.scala 90:10]
    Regimm <= mux(reset, UInt<32>("h0"), io_imm) @[ID_EX.scala 71:23 ID_EX.scala 71:23 ID_EX.scala 91:10]
    Regrd_sel <= mux(reset, UInt<5>("h0"), io_rd_sel_in) @[ID_EX.scala 72:26 ID_EX.scala 72:26 ID_EX.scala 92:13]
    Regfunc3 <= mux(reset, UInt<3>("h0"), io_func3_in) @[ID_EX.scala 73:25 ID_EX.scala 73:25 ID_EX.scala 93:12]
    Regfunc7 <= mux(reset, UInt<7>("h0"), io_func7_in) @[ID_EX.scala 74:25 ID_EX.scala 74:25 ID_EX.scala 94:12]
    Reg_Ctrl_MemWr <= mux(reset, UInt<1>("h0"), io_ctrl_MemWr_in) @[ID_EX.scala 75:31 ID_EX.scala 75:31 ID_EX.scala 95:18]
    Reg_Ctrl_MemRd <= mux(reset, UInt<1>("h0"), io_ctrl_MemRd_in) @[ID_EX.scala 76:31 ID_EX.scala 76:31 ID_EX.scala 96:18]
    Reg_Ctrl_Branch <= mux(reset, UInt<1>("h0"), io_ctrl_Branch_in) @[ID_EX.scala 77:32 ID_EX.scala 77:32 ID_EX.scala 97:19]
    Reg_Ctrl_RegWr <= mux(reset, UInt<1>("h0"), io_ctrl_RegWr_in) @[ID_EX.scala 78:31 ID_EX.scala 78:31 ID_EX.scala 98:18]
    Reg_Ctrl_MemtoReg <= mux(reset, UInt<1>("h0"), io_ctrl_MemtoReg_in) @[ID_EX.scala 79:34 ID_EX.scala 79:34 ID_EX.scala 99:21]
    Reg_Ctrl_AluOp <= mux(reset, UInt<4>("h0"), io_ctrl_ALUOP_in) @[ID_EX.scala 80:31 ID_EX.scala 80:31 ID_EX.scala 100:18]
    Reg_Ctrl_OpA <= mux(reset, UInt<1>("h0"), io_ctrl_OpA_sel_in) @[ID_EX.scala 81:29 ID_EX.scala 81:29 ID_EX.scala 101:16]
    Reg_Ctrl_OpB <= mux(reset, UInt<1>("h0"), io_ctrl_OpB_sel_in) @[ID_EX.scala 82:29 ID_EX.scala 82:29 ID_EX.scala 102:16]
    Reg_Ctrl_nextPc <= mux(reset, UInt<2>("h0"), io_ctrl_nextPc_sel_in) @[ID_EX.scala 83:32 ID_EX.scala 83:32 ID_EX.scala 103:19]

  module EX_MEM :
    input clock : Clock
    input reset : UInt<1>
    input io_id_ex_memWr : UInt<1>
    input io_id_ex_memRd : UInt<1>
    input io_id_ex_memToReg : UInt<1>
    input io_id_ex_rs2 : UInt<32>
    input io_id_ex_rdSel : UInt<5>
    input io_id_ex_rs2Sel : UInt<5>
    input io_alu_output : UInt<32>
    input io_id_ex_regWr : UInt<1>
    output io_ex_mem_memWr_out : UInt<1>
    output io_ex_mem_memRd_out : UInt<1>
    output io_ex_mem_memToReg_out : UInt<1>
    output io_ex_mem_rs2_output : UInt<32>
    output io_ex_mem_rdSel_output : UInt<5>
    output io_ex_mem_rs2Sel_output : UInt<5>
    output io_ex_mem_alu_output : UInt<32>
    output io_ex_mem_regWr_out : UInt<1>

    reg regMemWr : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regMemWr) @[EX_MEM.scala 32:25]
    reg regMemRd : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regMemRd) @[EX_MEM.scala 33:25]
    reg regMemToReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regMemToReg) @[EX_MEM.scala 34:28]
    reg regRs2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regRs2) @[EX_MEM.scala 35:23]
    reg regRdSel : UInt<5>, clock with :
      reset => (UInt<1>("h0"), regRdSel) @[EX_MEM.scala 36:25]
    reg regRs2Sel : UInt<5>, clock with :
      reset => (UInt<1>("h0"), regRs2Sel) @[EX_MEM.scala 37:26]
    reg regAluOutput : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regAluOutput) @[EX_MEM.scala 38:29]
    reg regRegWr : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regRegWr) @[EX_MEM.scala 39:25]
    io_ex_mem_memWr_out <= regMemWr @[EX_MEM.scala 52:23]
    io_ex_mem_memRd_out <= regMemRd @[EX_MEM.scala 53:23]
    io_ex_mem_memToReg_out <= regMemToReg @[EX_MEM.scala 54:26]
    io_ex_mem_rs2_output <= regRs2 @[EX_MEM.scala 55:24]
    io_ex_mem_rdSel_output <= regRdSel @[EX_MEM.scala 56:26]
    io_ex_mem_rs2Sel_output <= regRs2Sel @[EX_MEM.scala 57:27]
    io_ex_mem_alu_output <= regAluOutput @[EX_MEM.scala 58:24]
    io_ex_mem_regWr_out <= regRegWr @[EX_MEM.scala 59:23]
    regMemWr <= mux(reset, UInt<1>("h0"), io_id_ex_memWr) @[EX_MEM.scala 32:25 EX_MEM.scala 32:25 EX_MEM.scala 42:12]
    regMemRd <= mux(reset, UInt<1>("h0"), io_id_ex_memRd) @[EX_MEM.scala 33:25 EX_MEM.scala 33:25 EX_MEM.scala 43:12]
    regMemToReg <= mux(reset, UInt<1>("h0"), io_id_ex_memToReg) @[EX_MEM.scala 34:28 EX_MEM.scala 34:28 EX_MEM.scala 44:15]
    regRs2 <= mux(reset, UInt<32>("h0"), io_id_ex_rs2) @[EX_MEM.scala 35:23 EX_MEM.scala 35:23 EX_MEM.scala 45:10]
    regRdSel <= mux(reset, UInt<5>("h0"), io_id_ex_rdSel) @[EX_MEM.scala 36:25 EX_MEM.scala 36:25 EX_MEM.scala 46:12]
    regRs2Sel <= mux(reset, UInt<5>("h0"), io_id_ex_rs2Sel) @[EX_MEM.scala 37:26 EX_MEM.scala 37:26 EX_MEM.scala 47:13]
    regAluOutput <= mux(reset, UInt<32>("h0"), io_alu_output) @[EX_MEM.scala 38:29 EX_MEM.scala 38:29 EX_MEM.scala 48:16]
    regRegWr <= mux(reset, UInt<1>("h0"), io_id_ex_regWr) @[EX_MEM.scala 39:25 EX_MEM.scala 39:25 EX_MEM.scala 49:12]

  module MEM_WB :
    input clock : Clock
    input reset : UInt<1>
    input io_EX_MEM_REGWR : UInt<1>
    input io_EX_MEM_MEMTOREG : UInt<1>
    input io_EX_MEM_RDSEL : UInt<5>
    input io_EX_MEM_MEMRD : UInt<1>
    input io_in_dataMem_data : UInt<32>
    input io_in_alu_output : UInt<32>
    output io_mem_wb_regWr_output : UInt<1>
    output io_mem_wb_memToReg_output : UInt<1>
    output io_mem_wb_rdSel_output : UInt<5>
    output io_mem_wb_memRd_output : UInt<1>
    output io_mem_wb_dataMem_data : UInt<32>
    output io_mem_wb_alu_output : UInt<32>

    reg Reg_MEM_WB_REGWR : UInt<1>, clock with :
      reset => (UInt<1>("h0"), Reg_MEM_WB_REGWR) @[MEM_WB.scala 26:33]
    reg Reg_MEM_WB_MEMTOREG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), Reg_MEM_WB_MEMTOREG) @[MEM_WB.scala 27:36]
    reg Reg_MEM_WB_RDSEL : UInt<5>, clock with :
      reset => (UInt<1>("h0"), Reg_MEM_WB_RDSEL) @[MEM_WB.scala 28:33]
    reg Reg_MEM_WB_MEMRD : UInt<1>, clock with :
      reset => (UInt<1>("h0"), Reg_MEM_WB_MEMRD) @[MEM_WB.scala 29:33]
    reg Reg_dataMem_data : UInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_dataMem_data) @[MEM_WB.scala 30:33]
    reg Reg_alu_output : UInt<32>, clock with :
      reset => (UInt<1>("h0"), Reg_alu_output) @[MEM_WB.scala 31:31]
    io_mem_wb_regWr_output <= Reg_MEM_WB_REGWR @[MEM_WB.scala 42:26]
    io_mem_wb_memToReg_output <= Reg_MEM_WB_MEMTOREG @[MEM_WB.scala 43:29]
    io_mem_wb_rdSel_output <= Reg_MEM_WB_RDSEL @[MEM_WB.scala 44:26]
    io_mem_wb_memRd_output <= Reg_MEM_WB_MEMRD @[MEM_WB.scala 45:26]
    io_mem_wb_dataMem_data <= Reg_dataMem_data @[MEM_WB.scala 46:26]
    io_mem_wb_alu_output <= Reg_alu_output @[MEM_WB.scala 47:24]
    Reg_MEM_WB_REGWR <= mux(reset, UInt<1>("h0"), io_EX_MEM_REGWR) @[MEM_WB.scala 26:33 MEM_WB.scala 26:33 MEM_WB.scala 34:20]
    Reg_MEM_WB_MEMTOREG <= mux(reset, UInt<1>("h0"), io_EX_MEM_MEMTOREG) @[MEM_WB.scala 27:36 MEM_WB.scala 27:36 MEM_WB.scala 35:23]
    Reg_MEM_WB_RDSEL <= mux(reset, UInt<5>("h0"), io_EX_MEM_RDSEL) @[MEM_WB.scala 28:33 MEM_WB.scala 28:33 MEM_WB.scala 36:20]
    Reg_MEM_WB_MEMRD <= mux(reset, UInt<1>("h0"), io_EX_MEM_MEMRD) @[MEM_WB.scala 29:33 MEM_WB.scala 29:33 MEM_WB.scala 37:20]
    Reg_dataMem_data <= mux(reset, UInt<32>("h0"), io_in_dataMem_data) @[MEM_WB.scala 30:33 MEM_WB.scala 30:33 MEM_WB.scala 38:20]
    Reg_alu_output <= mux(reset, UInt<32>("h0"), io_in_alu_output) @[MEM_WB.scala 31:31 MEM_WB.scala 31:31 MEM_WB.scala 39:18]

  module ForwardingUnit :
    input clock : Clock
    input reset : UInt<1>
    input io_exMemRegWrite : UInt<1>
    input io_memWbRegWrite : UInt<1>
    input io_memWbRdAddr : UInt<5>
    input io_exMemRdAddr : UInt<5>
    input io_idExRs1Addr : UInt<5>
    input io_idExRs2Addr : UInt<5>
    output io_forwardA : UInt<2>
    output io_forwardB : UInt<2>

    node _T = neq(io_exMemRdAddr, UInt<1>("h0")) @[Forwardin_Unit.scala 21:45]
    node _T_1 = and(io_exMemRegWrite, _T) @[Forwardin_Unit.scala 21:27]
    node _T_2 = eq(io_exMemRdAddr, io_idExRs1Addr) @[Forwardin_Unit.scala 22:29]
    node _GEN_0 = mux(_T_2, UInt<1>("h1"), UInt<1>("h0")) @[Forwardin_Unit.scala 22:49 Forwardin_Unit.scala 23:25 Forwardin_Unit.scala 17:17]
    node _T_3 = eq(io_exMemRdAddr, io_idExRs2Addr) @[Forwardin_Unit.scala 25:29]
    node _GEN_1 = mux(_T_3, UInt<1>("h1"), UInt<1>("h0")) @[Forwardin_Unit.scala 25:49 Forwardin_Unit.scala 26:25 Forwardin_Unit.scala 18:17]
    node _GEN_2 = mux(_T_1, _GEN_0, UInt<1>("h0")) @[Forwardin_Unit.scala 21:54 Forwardin_Unit.scala 17:17]
    node _GEN_3 = mux(_T_1, _GEN_1, UInt<1>("h0")) @[Forwardin_Unit.scala 21:54 Forwardin_Unit.scala 18:17]
    node _T_4 = neq(io_memWbRdAddr, UInt<1>("h0")) @[Forwardin_Unit.scala 31:45]
    node _T_5 = and(io_memWbRegWrite, _T_4) @[Forwardin_Unit.scala 31:27]
    node _T_6 = eq(io_memWbRdAddr, io_idExRs1Addr) @[Forwardin_Unit.scala 32:29]
    node _T_7 = eq(io_exMemRdAddr, io_idExRs1Addr) @[Forwardin_Unit.scala 32:88]
    node _T_8 = and(io_exMemRegWrite, _T_7) @[Forwardin_Unit.scala 32:70]
    node _T_9 = eq(_T_8, UInt<1>("h0")) @[Forwardin_Unit.scala 32:51]
    node _T_10 = and(_T_6, _T_9) @[Forwardin_Unit.scala 32:48]
    node _GEN_4 = mux(_T_10, UInt<2>("h2"), _GEN_2) @[Forwardin_Unit.scala 32:109 Forwardin_Unit.scala 33:25]
    node _T_11 = eq(io_memWbRdAddr, io_idExRs2Addr) @[Forwardin_Unit.scala 35:29]
    node _T_12 = eq(io_exMemRdAddr, io_idExRs2Addr) @[Forwardin_Unit.scala 35:88]
    node _T_13 = and(io_exMemRegWrite, _T_12) @[Forwardin_Unit.scala 35:70]
    node _T_14 = eq(_T_13, UInt<1>("h0")) @[Forwardin_Unit.scala 35:51]
    node _T_15 = and(_T_11, _T_14) @[Forwardin_Unit.scala 35:48]
    node _GEN_5 = mux(_T_15, UInt<2>("h2"), _GEN_3) @[Forwardin_Unit.scala 35:109 Forwardin_Unit.scala 36:25]
    node _GEN_6 = mux(_T_5, _GEN_4, _GEN_2) @[Forwardin_Unit.scala 31:54]
    node _GEN_7 = mux(_T_5, _GEN_5, _GEN_3) @[Forwardin_Unit.scala 31:54]
    io_forwardA <= _GEN_6
    io_forwardB <= _GEN_7

  module HazardDetection :
    input clock : Clock
    input reset : UInt<1>
    input io_IF_ID_INST : UInt<32>
    input io_ID_EX_MEMREAD : UInt<1>
    input io_ID_EX_REGRD : UInt<5>
    input io_pc_in : SInt<32>
    input io_in_pc4 : SInt<32>
    output io_inst_forward : UInt<1>
    output io_pc_forward : UInt<1>
    output io_ctrl_forward : UInt<1>
    output io_inst_out : UInt<32>
    output io_pc_out : SInt<32>
    output io_pc4_out : SInt<32>

    node rs1 = bits(io_IF_ID_INST, 19, 15) @[Hazard_Detection.scala 25:26]
    node rs2 = bits(io_IF_ID_INST, 24, 20) @[Hazard_Detection.scala 26:26]
    node _T = eq(io_ID_EX_REGRD, rs1) @[Hazard_Detection.scala 37:45]
    node _T_1 = eq(io_ID_EX_REGRD, rs2) @[Hazard_Detection.scala 37:73]
    node _T_2 = or(_T, _T_1) @[Hazard_Detection.scala 37:54]
    node _T_3 = and(io_ID_EX_MEMREAD, _T_2) @[Hazard_Detection.scala 37:25]
    node _GEN_0 = mux(_T_3, UInt<1>("h1"), UInt<1>("h0")) @[Hazard_Detection.scala 37:84 Hazard_Detection.scala 39:21 Hazard_Detection.scala 28:19]
    node _GEN_1 = mux(_T_3, io_IF_ID_INST, io_IF_ID_INST) @[Hazard_Detection.scala 37:84 Hazard_Detection.scala 42:17 Hazard_Detection.scala 32:15]
    node _GEN_2 = mux(_T_3, io_pc4_out, io_pc_in) @[Hazard_Detection.scala 37:84 Hazard_Detection.scala 43:15 Hazard_Detection.scala 33:13]
    node _GEN_3 = mux(_T_3, io_pc_in, io_pc_in) @[Hazard_Detection.scala 37:84 Hazard_Detection.scala 44:16 Hazard_Detection.scala 34:14]
    io_inst_forward <= _GEN_0
    io_pc_forward <= _GEN_0
    io_ctrl_forward <= _GEN_0
    io_inst_out <= _GEN_1
    io_pc_out <= _GEN_2
    io_pc4_out <= _GEN_3

  module TOP :
    input clock : Clock
    input reset : UInt<1>
    output io_out : UInt<32>

    inst Instr_Mod of Instruction_Memory @[TOP.scala 15:27]
    inst CU_Mod of Control_Unit @[TOP.scala 16:24]
    inst ALU_Mod of ALU @[TOP.scala 17:25]
    inst Data_Memory_Mod of Data_Memory @[TOP.scala 18:33]
    inst Immediate_Gen_Mod of ImmdValGen @[TOP.scala 19:35]
    inst PC_Mod of PC @[TOP.scala 20:24]
    inst Jalr_Mod of Jalr @[TOP.scala 21:26]
    inst Reg_Mod of Register_File @[TOP.scala 22:25]
    inst ALU_Branch of ALU_Branch_Control @[TOP.scala 23:28]
    inst ifId of IF_ID @[TOP.scala 26:22]
    inst idEx of ID_EX @[TOP.scala 27:22]
    inst ExMem of EX_MEM @[TOP.scala 28:23]
    inst MemWb of MEM_WB @[TOP.scala 29:23]
    inst FwdUnit of ForwardingUnit @[TOP.scala 30:25]
    inst HazardDetect of HazardDetection @[TOP.scala 31:30]
    node Main_ALU_Mux = mux(ALU_Mod.io_CU_Branch_taken, ALU_Mod.io_in_A, ALU_Mod.io_in_B) @[TOP.scala 55:27]
    node br = and(ALU_Mod.io_CU_Branch_taken, CU_Mod.io_CU_Branch) @[TOP.scala 58:41]
    node Br_Mux = mux(br, Immediate_Gen_Mod.io_immd_se_SB, PC_Mod.io_pc4) @[TOP.scala 59:21]
    node _pc_input_T = eq(UInt<1>("h1"), CU_Mod.io_CU_Next_PC) @[Mux.scala 80:60]
    node _pc_input_T_1 = mux(_pc_input_T, Br_Mux, PC_Mod.io_pc4) @[Mux.scala 80:57]
    node _pc_input_T_2 = eq(UInt<2>("h2"), CU_Mod.io_CU_Next_PC) @[Mux.scala 80:60]
    node _pc_input_T_3 = mux(_pc_input_T_2, Immediate_Gen_Mod.io_immd_se_UJ, _pc_input_T_1) @[Mux.scala 80:57]
    node _pc_input_T_4 = eq(UInt<2>("h3"), CU_Mod.io_CU_Next_PC) @[Mux.scala 80:60]
    node pc_input = mux(_pc_input_T_4, Jalr_Mod.io_imm, _pc_input_T_3) @[Mux.scala 80:57]
    node _Instr_Mod_io_memory_address_T = bits(PC_Mod.io_pc1, 21, 2) @[TOP.scala 72:49]
    node _CU_Mod_io_CU_Opcode_T = bits(Instr_Mod.io_memory_instruction, 6, 0) @[TOP.scala 80:59]
    node _Reg_Mod_io_ReadReg1_T = bits(Instr_Mod.io_memory_instruction, 19, 15) @[TOP.scala 83:59]
    node _Reg_Mod_io_ReadReg2_T = bits(Instr_Mod.io_memory_instruction, 24, 20) @[TOP.scala 84:59]
    node _Reg_Mod_io_WriteReg_T = bits(Instr_Mod.io_memory_instruction, 11, 7) @[TOP.scala 85:60]
    node _Reg_Mod_io_WriteData_T = asSInt(ALU_Mod.io_out) @[TOP.scala 87:113]
    node _Reg_Mod_io_WriteData_T_1 = mux(CU_Mod.io_CU_MemToReg, Data_Memory_Mod.io_Data_Mem_output, _Reg_Mod_io_WriteData_T) @[TOP.scala 87:32]
    node _Immediate_Gen_Mod_io_Imm_instr_T = asSInt(Instr_Mod.io_memory_instruction) @[TOP.scala 90:77]
    node _Data_Memory_Mod_io_Data_Mem_address_T = bits(ExMem.io_alu_output, 11, 2) @[TOP.scala 94:63]
    node _Data_Memory_Mod_io_Data_Mem_data_T = asSInt(ExMem.io_ex_mem_rs2_output) @[TOP.scala 95:74]
    node _idEx_io_rs1_in_T = asUInt(Reg_Mod.io_ReadData1) @[TOP.scala 103:44]
    node _idEx_io_rs2_in_T = asUInt(Reg_Mod.io_ReadData2) @[TOP.scala 104:44]
    node _idEx_io_imm_T = asUInt(ifId.io_pc_in) @[TOP.scala 105:40]
    node _idEx_io_rd_sel_in_T = bits(ifId.io_instr_out, 11, 7) @[TOP.scala 106:43]
    node _idEx_io_func3_in_T = bits(ifId.io_instr_out, 14, 12) @[TOP.scala 107:42]
    node _idEx_io_func7_in_T = bits(ifId.io_instr_out, 31, 25) @[TOP.scala 108:42]
    node _ALU_Mux_1_T = eq(UInt<1>("h1"), CU_Mod.io_CU_InA) @[Mux.scala 80:60]
    node _ALU_Mux_1_T_1 = mux(_ALU_Mux_1_T, PC_Mod.io_pc1, Reg_Mod.io_ReadData1) @[Mux.scala 80:57]
    node _ALU_Mux_1_T_2 = eq(UInt<2>("h2"), CU_Mod.io_CU_InA) @[Mux.scala 80:60]
    node _ALU_Mux_1_T_3 = mux(_ALU_Mux_1_T_2, PC_Mod.io_pc4, _ALU_Mux_1_T_1) @[Mux.scala 80:57]
    node _ALU_Mux_1_T_4 = eq(UInt<2>("h3"), CU_Mod.io_CU_InA) @[Mux.scala 80:60]
    node _ALU_Mux_1_T_5 = mux(_ALU_Mux_1_T_4, Reg_Mod.io_ReadData1, _ALU_Mux_1_T_3) @[Mux.scala 80:57]
    node ALU_Mux_1 = _ALU_Mux_1_T_5 @[TOP.scala 112:25 TOP.scala 113:15]
    node _ExMem_io_id_ex_rs2_T = asUInt(ALU_Mux_1) @[TOP.scala 128:42]
    node _MemWb_io_in_dataMem_data_T = asUInt(Data_Memory_Mod.io_Data_Mem_output) @[TOP.scala 132:74]
    node _T = eq(idEx.io_ctrl_OpA_sel_out, UInt<2>("h2")) @[TOP.scala 147:35]
    node _ALU_Mod_io_in_A_T = asUInt(idEx.io_pc_out) @[TOP.scala 148:49]
    node _ALU_Mod_io_in_A_T_1 = eq(FwdUnit.io_forwardA, UInt<1>("h1")) @[TOP.scala 151:34]
    node _ALU_Mod_io_in_A_T_2 = eq(FwdUnit.io_forwardA, UInt<2>("h2")) @[TOP.scala 152:34]
    node _ALU_Mod_io_in_A_T_3 = asUInt(Reg_Mod.io_WriteData) @[TOP.scala 152:77]
    node _ALU_Mod_io_in_A_T_4 = eq(FwdUnit.io_forwardA, UInt<1>("h0")) @[TOP.scala 153:34]
    node _ALU_Mod_io_in_A_T_5 = mux(_ALU_Mod_io_in_A_T_4, idEx.io_rs1_out, idEx.io_rs1_out) @[Mux.scala 98:16]
    node _ALU_Mod_io_in_A_T_6 = mux(_ALU_Mod_io_in_A_T_2, _ALU_Mod_io_in_A_T_3, _ALU_Mod_io_in_A_T_5) @[Mux.scala 98:16]
    node _ALU_Mod_io_in_A_T_7 = mux(_ALU_Mod_io_in_A_T_1, ExMem.io_ex_mem_alu_output, _ALU_Mod_io_in_A_T_6) @[Mux.scala 98:16]
    node _GEN_0 = mux(_T, _ALU_Mod_io_in_A_T, _ALU_Mod_io_in_A_T_7) @[TOP.scala 147:48 TOP.scala 148:25 TOP.scala 150:25]
    node _T_1 = eq(idEx.io_ctrl_OpB_sel_out, UInt<1>("h1")) @[TOP.scala 157:35]
    node _ExMem_io_id_ex_rs2_T_1 = eq(FwdUnit.io_forwardB, UInt<1>("h1")) @[TOP.scala 160:34]
    node _ExMem_io_id_ex_rs2_T_2 = eq(FwdUnit.io_forwardB, UInt<2>("h2")) @[TOP.scala 161:34]
    node _ExMem_io_id_ex_rs2_T_3 = asUInt(Reg_Mod.io_WriteData) @[TOP.scala 161:77]
    node _ExMem_io_id_ex_rs2_T_4 = eq(FwdUnit.io_forwardB, UInt<1>("h0")) @[TOP.scala 162:34]
    node _ExMem_io_id_ex_rs2_T_5 = mux(_ExMem_io_id_ex_rs2_T_4, idEx.io_rs2_out, idEx.io_rs2_out) @[Mux.scala 98:16]
    node _ExMem_io_id_ex_rs2_T_6 = mux(_ExMem_io_id_ex_rs2_T_2, _ExMem_io_id_ex_rs2_T_3, _ExMem_io_id_ex_rs2_T_5) @[Mux.scala 98:16]
    node _ExMem_io_id_ex_rs2_T_7 = mux(_ExMem_io_id_ex_rs2_T_1, ExMem.io_alu_output, _ExMem_io_id_ex_rs2_T_6) @[Mux.scala 98:16]
    node _ALU_Mod_io_in_B_T = eq(FwdUnit.io_forwardB, UInt<1>("h1")) @[TOP.scala 166:34]
    node _ALU_Mod_io_in_B_T_1 = eq(FwdUnit.io_forwardB, UInt<2>("h2")) @[TOP.scala 167:34]
    node _ALU_Mod_io_in_B_T_2 = asUInt(Reg_Mod.io_WriteData) @[TOP.scala 167:77]
    node _ALU_Mod_io_in_B_T_3 = eq(FwdUnit.io_forwardB, UInt<1>("h0")) @[TOP.scala 168:34]
    node _ALU_Mod_io_in_B_T_4 = mux(_ALU_Mod_io_in_B_T_3, idEx.io_rs2_out, idEx.io_rs2_out) @[Mux.scala 98:16]
    node _ALU_Mod_io_in_B_T_5 = mux(_ALU_Mod_io_in_B_T_1, _ALU_Mod_io_in_B_T_2, _ALU_Mod_io_in_B_T_4) @[Mux.scala 98:16]
    node _ALU_Mod_io_in_B_T_6 = mux(_ALU_Mod_io_in_B_T, ExMem.io_alu_output, _ALU_Mod_io_in_B_T_5) @[Mux.scala 98:16]
    node _GEN_1 = mux(_T_1, idEx.io_imm_out, _ALU_Mod_io_in_B_T_6) @[TOP.scala 157:47 TOP.scala 158:25 TOP.scala 165:25]
    node _GEN_2 = mux(_T_1, _ExMem_io_id_ex_rs2_T_7, ALU_Mod.io_in_B) @[TOP.scala 157:47 TOP.scala 159:28 TOP.scala 170:28]
    node _Imm_Mux_Output_T = eq(UInt<1>("h0"), CU_Mod.io_CU_Extend_sel) @[Mux.scala 80:60]
    node _Imm_Mux_Output_T_1 = mux(_Imm_Mux_Output_T, Immediate_Gen_Mod.io_immd_se_I, asSInt(UInt<1>("h0"))) @[Mux.scala 80:57]
    node _Imm_Mux_Output_T_2 = eq(UInt<1>("h1"), CU_Mod.io_CU_Extend_sel) @[Mux.scala 80:60]
    node _Imm_Mux_Output_T_3 = mux(_Imm_Mux_Output_T_2, Immediate_Gen_Mod.io_immd_se_S, _Imm_Mux_Output_T_1) @[Mux.scala 80:57]
    node _Imm_Mux_Output_T_4 = eq(UInt<2>("h2"), CU_Mod.io_CU_Extend_sel) @[Mux.scala 80:60]
    node _Imm_Mux_Output_T_5 = mux(_Imm_Mux_Output_T_4, Immediate_Gen_Mod.io_immd_se_U, _Imm_Mux_Output_T_3) @[Mux.scala 80:57]
    node _GEN_3 = mux(HazardDetect.io_inst_forward, HazardDetect.io_inst_out, Instr_Mod.io_memory_instruction) @[TOP.scala 187:40 TOP.scala 188:24 TOP.scala 191:24]
    node _GEN_4 = mux(HazardDetect.io_inst_forward, HazardDetect.io_pc_out, PC_Mod.io_pc) @[TOP.scala 187:40 TOP.scala 189:21 TOP.scala 75:19]
    node _T_2 = eq(CU_Mod.io_CU_Next_PC, UInt<1>("h1")) @[TOP.scala 205:33]
    node _T_3 = eq(ALU_Branch.io_CU_Branch_taken, UInt<1>("h1")) @[TOP.scala 206:44]
    node _T_4 = eq(CU_Mod.io_CU_Branch, UInt<1>("h1")) @[TOP.scala 206:75]
    node _T_5 = and(_T_3, _T_4) @[TOP.scala 206:52]
    node _GEN_5 = mux(_T_5, Immediate_Gen_Mod.io_immd_se_SB, PC_Mod.io_pc4) @[TOP.scala 206:84 TOP.scala 207:24 TOP.scala 211:24]
    node _GEN_6 = mux(_T_5, asSInt(UInt<1>("h0")), _GEN_4) @[TOP.scala 206:84 TOP.scala 208:25]
    node _GEN_7 = mux(_T_5, UInt<1>("h0"), _GEN_3) @[TOP.scala 206:84 TOP.scala 209:28]
    node _T_6 = eq(CU_Mod.io_CU_Next_PC, UInt<2>("h2")) @[TOP.scala 213:39]
    node _GEN_8 = mux(_T_6, Immediate_Gen_Mod.io_immd_se_UJ, PC_Mod.io_pc4) @[TOP.scala 213:52 TOP.scala 214:22 TOP.scala 218:22]
    node _GEN_9 = mux(_T_6, asSInt(UInt<1>("h0")), PC_Mod.io_pc4) @[TOP.scala 213:52 TOP.scala 215:24 TOP.scala 76:20]
    node _GEN_10 = mux(_T_6, UInt<1>("h0"), _GEN_3) @[TOP.scala 213:52 TOP.scala 216:26]
    node _GEN_11 = mux(_T_2, _GEN_5, _GEN_8) @[TOP.scala 205:46]
    node _GEN_12 = mux(_T_2, _GEN_6, _GEN_4) @[TOP.scala 205:46]
    node _GEN_13 = mux(_T_2, _GEN_7, _GEN_10) @[TOP.scala 205:46]
    node _GEN_14 = mux(_T_2, PC_Mod.io_pc4, _GEN_9) @[TOP.scala 205:46 TOP.scala 76:20]
    node _GEN_15 = mux(HazardDetect.io_pc_forward, HazardDetect.io_pc_out, _GEN_11) @[TOP.scala 202:38 TOP.scala 203:20]
    node _GEN_16 = mux(HazardDetect.io_pc_forward, _GEN_4, _GEN_12) @[TOP.scala 202:38]
    node _GEN_17 = mux(HazardDetect.io_pc_forward, _GEN_3, _GEN_13) @[TOP.scala 202:38]
    node _GEN_18 = mux(HazardDetect.io_pc_forward, PC_Mod.io_pc4, _GEN_14) @[TOP.scala 202:38 TOP.scala 76:20]
    node _GEN_19 = mux(HazardDetect.io_ctrl_forward, UInt<1>("h0"), CU_Mod.io_CU_MemWrite) @[TOP.scala 223:40 TOP.scala 224:29 TOP.scala 234:29]
    node _GEN_20 = mux(HazardDetect.io_ctrl_forward, UInt<1>("h0"), CU_Mod.io_CU_MemRead) @[TOP.scala 223:40 TOP.scala 225:29 TOP.scala 235:29]
    node _GEN_21 = mux(HazardDetect.io_ctrl_forward, UInt<1>("h0"), CU_Mod.io_CU_Branch) @[TOP.scala 223:40 TOP.scala 226:30 TOP.scala 236:30]
    node _GEN_22 = mux(HazardDetect.io_ctrl_forward, UInt<1>("h0"), CU_Mod.io_CU_RegWrite) @[TOP.scala 223:40 TOP.scala 227:29 TOP.scala 237:29]
    node _GEN_23 = mux(HazardDetect.io_ctrl_forward, UInt<1>("h0"), CU_Mod.io_CU_ALU_op) @[TOP.scala 223:40 TOP.scala 229:29 TOP.scala 239:29]
    node _GEN_24 = mux(HazardDetect.io_ctrl_forward, UInt<1>("h0"), CU_Mod.io_CU_InA) @[TOP.scala 223:40 TOP.scala 230:31 TOP.scala 240:31]
    node _GEN_25 = mux(HazardDetect.io_ctrl_forward, UInt<1>("h0"), CU_Mod.io_CU_InB) @[TOP.scala 223:40 TOP.scala 231:31 TOP.scala 241:31]
    node _GEN_26 = mux(HazardDetect.io_ctrl_forward, UInt<1>("h0"), CU_Mod.io_CU_Next_PC) @[TOP.scala 223:40 TOP.scala 232:34 TOP.scala 242:34]
    node Imm_Mux_Output = _Imm_Mux_Output_T_5 @[TOP.scala 174:30 TOP.scala 175:20]
    node ALU_Mux_2 = mux(CU_Mod.io_CU_InB, Imm_Mux_Output, Reg_Mod.io_ReadData2) @[TOP.scala 246:24]
    node Func3 = bits(Instr_Mod.io_memory_instruction, 14, 12) @[TOP.scala 249:48]
    node Func7 = bits(Instr_Mod.io_memory_instruction, 30, 30) @[TOP.scala 250:48]
    node _ALU_Mod_io_in_A_T_8 = asUInt(ALU_Mux_1) @[TOP.scala 255:40]
    node _ALU_Mod_io_in_B_T_7 = asUInt(ALU_Mux_2) @[TOP.scala 256:40]
    io_out <= CU_Mod.io_CU_MemWrite @[TOP.scala 264:8]
    Instr_Mod.clock <= clock
    Instr_Mod.reset <= reset
    Instr_Mod.io_memory_address <= _Instr_Mod_io_memory_address_T @[TOP.scala 72:33]
    CU_Mod.clock <= clock
    CU_Mod.reset <= reset
    CU_Mod.io_CU_Opcode <= _CU_Mod_io_CU_Opcode_T @[TOP.scala 80:25]
    ALU_Mod.clock <= clock
    ALU_Mod.reset <= reset
    ALU_Mod.io_in_A <= _ALU_Mod_io_in_A_T_8 @[TOP.scala 255:21]
    ALU_Mod.io_in_B <= _ALU_Mod_io_in_B_T_7 @[TOP.scala 256:21]
    ALU_Mod.io_func3 <= CU_Mod.io_CU_Opcode @[TOP.scala 259:22]
    ALU_Mod.io_alu_Op <= CU_Mod.io_CU_ALU_op @[TOP.scala 252:23]
    Data_Memory_Mod.clock <= clock
    Data_Memory_Mod.reset <= reset
    Data_Memory_Mod.io_Data_Mem_address <= _Data_Memory_Mod_io_Data_Mem_address_T @[TOP.scala 94:41]
    Data_Memory_Mod.io_Data_Mem_data <= _Data_Memory_Mod_io_Data_Mem_data_T @[TOP.scala 95:38]
    Data_Memory_Mod.io_Data_Mem_write <= ExMem.io_ex_mem_memWr_out @[TOP.scala 96:39]
    Data_Memory_Mod.io_Data_Mem_read <= ExMem.io_ex_mem_memWr_out @[TOP.scala 97:38]
    Immediate_Gen_Mod.clock <= clock
    Immediate_Gen_Mod.reset <= reset
    Immediate_Gen_Mod.io_Imm_pc <= ifId.io_pc_out @[TOP.scala 91:33]
    Immediate_Gen_Mod.io_Imm_instr <= _Immediate_Gen_Mod_io_Imm_instr_T @[TOP.scala 90:36]
    PC_Mod.clock <= clock
    PC_Mod.reset <= reset
    PC_Mod.io_pc <= _GEN_15
    Jalr_Mod.clock <= clock
    Jalr_Mod.reset <= reset
    Jalr_Mod.io_rd <= Reg_Mod.io_ReadData1 @[TOP.scala 182:20]
    Jalr_Mod.io_rs1 <= Imm_Mux_Output @[TOP.scala 183:21]
    Reg_Mod.clock <= clock
    Reg_Mod.reset <= reset
    Reg_Mod.io_ReadReg1 <= _Reg_Mod_io_ReadReg1_T @[TOP.scala 83:25]
    Reg_Mod.io_ReadReg2 <= _Reg_Mod_io_ReadReg2_T @[TOP.scala 84:25]
    Reg_Mod.io_RegWrite <= CU_Mod.io_CU_RegWrite @[TOP.scala 86:25]
    Reg_Mod.io_WriteReg <= _Reg_Mod_io_WriteReg_T @[TOP.scala 85:26]
    Reg_Mod.io_WriteData <= _Reg_Mod_io_WriteData_T_1 @[TOP.scala 87:26]
    ALU_Branch.clock <= clock
    ALU_Branch.reset <= reset
    ALU_Branch.io_fnct3 <= UInt<1>("h0") @[TOP.scala 51:26]
    ALU_Branch.io_CU_Branch <= UInt<1>("h0") @[TOP.scala 52:30]
    ALU_Branch.io_CU_Branch_alu_inx <= UInt<1>("h0") @[TOP.scala 49:36]
    ALU_Branch.io_CU_Branch_alu_iny <= UInt<1>("h0") @[TOP.scala 50:36]
    ifId.clock <= clock
    ifId.reset <= reset
    ifId.io_pc_in <= _GEN_16
    ifId.io_pc_in4 <= _GEN_18
    ifId.io_instr_in <= _GEN_17
    idEx.clock <= clock
    idEx.reset <= reset
    idEx.io_IF_ID_pc <= ifId.io_pc_out @[TOP.scala 100:22]
    idEx.io_rs1_sel_in <= Reg_Mod.io_ReadReg1 @[TOP.scala 101:24]
    idEx.io_rs2_sel_in <= Reg_Mod.io_ReadReg2 @[TOP.scala 102:24]
    idEx.io_rs1_in <= _idEx_io_rs1_in_T @[TOP.scala 103:20]
    idEx.io_rs2_in <= _idEx_io_rs2_in_T @[TOP.scala 104:20]
    idEx.io_imm <= _idEx_io_imm_T @[TOP.scala 105:17]
    idEx.io_rd_sel_in <= _idEx_io_rd_sel_in_T @[TOP.scala 106:23]
    idEx.io_func3_in <= _idEx_io_func3_in_T @[TOP.scala 107:22]
    idEx.io_func7_in <= _idEx_io_func7_in_T @[TOP.scala 108:22]
    idEx.io_ctrl_MemWr_in <= _GEN_19
    idEx.io_ctrl_MemRd_in <= _GEN_20
    idEx.io_ctrl_Branch_in <= _GEN_21
    idEx.io_ctrl_RegWr_in <= _GEN_22
    idEx.io_ctrl_MemtoReg_in <= _GEN_20
    idEx.io_ctrl_ALUOP_in <= _GEN_23
    idEx.io_ctrl_OpA_sel_in <= bits(_GEN_24, 0, 0)
    idEx.io_ctrl_OpB_sel_in <= _GEN_25
    idEx.io_ctrl_nextPc_sel_in <= _GEN_26
    ExMem.clock <= clock
    ExMem.reset <= reset
    ExMem.io_id_ex_memWr <= idEx.io_ctrl_MemWr_out @[TOP.scala 121:26]
    ExMem.io_id_ex_memRd <= idEx.io_ctrl_MemRd_out @[TOP.scala 122:26]
    ExMem.io_id_ex_memToReg <= idEx.io_ctrl_MemtoReg_out @[TOP.scala 123:29]
    ExMem.io_id_ex_rs2 <= _GEN_2
    ExMem.io_id_ex_rdSel <= idEx.io_rd_sel_out @[TOP.scala 125:26]
    ExMem.io_id_ex_rs2Sel <= idEx.io_rs2_sel_out @[TOP.scala 126:27]
    ExMem.io_alu_output <= ALU_Mod.io_out @[TOP.scala 124:25]
    ExMem.io_id_ex_regWr <= idEx.io_ctrl_RegWr_out @[TOP.scala 127:26]
    MemWb.clock <= clock
    MemWb.reset <= reset
    MemWb.io_EX_MEM_REGWR <= ExMem.io_ex_mem_memToReg_out @[TOP.scala 136:27]
    MemWb.io_EX_MEM_MEMTOREG <= ExMem.io_ex_mem_memToReg_out @[TOP.scala 131:30]
    MemWb.io_EX_MEM_RDSEL <= ExMem.io_ex_mem_rdSel_output @[TOP.scala 134:27]
    MemWb.io_EX_MEM_MEMRD <= ExMem.io_ex_mem_memRd_out @[TOP.scala 135:27]
    MemWb.io_in_dataMem_data <= _MemWb_io_in_dataMem_data_T @[TOP.scala 132:30]
    MemWb.io_in_alu_output <= ExMem.io_alu_output @[TOP.scala 133:28]
    FwdUnit.clock <= clock
    FwdUnit.reset <= reset
    FwdUnit.io_exMemRegWrite <= MemWb.io_EX_MEM_REGWR @[TOP.scala 140:30]
    FwdUnit.io_memWbRegWrite <= bits(MemWb.io_EX_MEM_RDSEL, 0, 0) @[TOP.scala 142:30]
    FwdUnit.io_memWbRdAddr <= ExMem.io_ex_mem_rdSel_output @[TOP.scala 141:28]
    FwdUnit.io_exMemRdAddr <= ExMem.io_ex_mem_memWr_out @[TOP.scala 139:28]
    FwdUnit.io_idExRs1Addr <= idEx.io_rs1_sel_out @[TOP.scala 143:28]
    FwdUnit.io_idExRs2Addr <= idEx.io_rs2_sel_out @[TOP.scala 144:28]
    HazardDetect.clock <= clock
    HazardDetect.reset <= reset
    HazardDetect.io_IF_ID_INST <= ifId.io_instr_out @[TOP.scala 197:32]
    HazardDetect.io_ID_EX_MEMREAD <= idEx.io_ctrl_MemRd_out @[TOP.scala 195:35]
    HazardDetect.io_ID_EX_REGRD <= idEx.io_rd_sel_out @[TOP.scala 196:33]
    HazardDetect.io_pc_in <= ifId.io_pc_out @[TOP.scala 198:27]
    HazardDetect.io_in_pc4 <= ifId.io_pc_out4 @[TOP.scala 199:28]
