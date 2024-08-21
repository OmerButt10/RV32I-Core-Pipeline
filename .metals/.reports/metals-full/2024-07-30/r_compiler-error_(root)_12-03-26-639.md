file://<HOME>/Single%20Cycle/src/main/scala/SC/ID_EX.scala
### scala.ScalaReflectionException: value rd_sel_in is not a method

occurred in the presentation compiler.

presentation compiler configuration:
Scala version: 2.12.13
Classpath:
<WORKSPACE>/.bloop/root/bloop-bsp-clients-classes/classes-Metals-HRFao66EQrK3sw3Ounz9Ew== [exists ], <HOME>/.cache/bloop/semanticdb/com.sourcegraph.semanticdb-javac.0.10.0/semanticdb-javac-0.10.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.12.13/scala-library-2.12.13.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3_2.12/3.4.3/chisel3_2.12-3.4.3.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3-macros_2.12/3.4.3/chisel3-macros_2.12-3.4.3.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3-core_2.12/3.4.3/chisel3-core_2.12-3.4.3.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.12.13/scala-reflect-2.12.13.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/scopt/scopt_2.12/3.7.1/scopt_2.12-3.7.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/firrtl_2.12/1.4.3/firrtl_2.12-1.4.3.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.7.1/antlr4-runtime-4.7.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.9.0/protobuf-java-3.9.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/net/jcazevedo/moultingyaml_2.12/0.4.2/moultingyaml_2.12-0.4.2.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-native_2.12/3.6.9/json4s-native_2.12-3.6.9.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-text/1.8/commons-text-1.8.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/nscala-time/nscala-time_2.12/2.22.0/nscala-time_2.12-2.22.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/yaml/snakeyaml/1.26/snakeyaml-1.26.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-core_2.12/3.6.9/json4s-core_2.12-3.6.9.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.9/commons-lang3-3.9.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/joda-time/joda-time/2.10.1/joda-time-2.10.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/joda/joda-convert/2.2.0/joda-convert-2.2.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-ast_2.12/3.6.9/json4s-ast_2.12-3.6.9.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-scalap_2.12/3.6.9/json4s-scalap_2.12-3.6.9.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8.jar [exists ]
Options:
-Xsource:2.11 -language:reflectiveCalls -deprecation -feature -Xcheckinit -Yrangepos -Xplugin-require:semanticdb


action parameters:
offset: 3152
uri: file://<HOME>/Single%20Cycle/src/main/scala/SC/ID_EX.scala
text:
```scala
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

    val rd_sel_in = Input(UInt(5.W)) /
    val rd_sel_out = Output(UInt(5.W))

    val func3_in = Input(UInt(3.W)) 
    val func3_out = Output(UInt(3.W))

    val func7_in = Input(UInt(7.W)) // 7-bit width for func7
    val func7_out = Output(UInt(7.W))

    val ctrl_MemWr_in = Input(Bool()) // Boolean for control signals
    val ctrl_MemWr_out = Output(Bool())

    val ctrl_MemRd_in = Input(Bool()) // Boolean for control signals
    val ctrl_MemRd_out = Output(Bool())

    val ctrl_Branch_in = Input(Bool()) // Boolean for control signals
    val ctrl_Branch_out = Output(Bool())

    val ctrl_RegWr_in = Input(Bool()) // Boolean for control signals
    val ctrl_RegWr_out = Output(Bool())

    val ctrl_MemtoReg_in = Input(Bool()) // Boolean for control signals
    val ctrl_MemtoReg_out = Output(Bool())

    val ctrl_ALUOP_in = Input(UInt(4.W)) // Assuming 4-bit width for ALUOP
    val ctrl_ALUOP_out = Output(UInt(4.W))

    val ctrl_OpA_sel_in = Input(Bool()) // Boolean for control signals
    val ctrl_OpA_sel_out = Output(Bool())

    val ctrl_OpB_sel_in = Input(Bool()) // Boolean for control signals
    val ctrl_OpB_sel_out = Output(Bool())

    val ctrl_nextPc_sel_in = Input(UInt(2.W)) // Assuming 2-bit width for next PC selection
    val ctrl_nextPc_sel_out = Output(UInt(2.W))
  })

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

  io.pc_out := RegID_EX_PC
  RegID_EX_PC := io.IF_ID_pc

  io.rs1_sel_out := Regrs1_sel
  Regrs1_sel := io.rs1_sel_in

  io.rs2_sel_out := Regrs2_sel
  Regrs2_sel := io.rs2_sel_in

  io.rs1_out := Regrs1
  Regrs1 := io.rs1_in

  io.rs2_out := Regrs2
  Regrs2 := io.rs2_in

  io.imm_out := Regimm
  Regimm := io.imm

  io.rd_sel_out := Regrd_sel
  Regrd_sel := io.rd_sel_in

  io.func3_out := Regfunc3
  Regfunc3 := io.func3_in

  io.func7_out := Regfunc7
  Regfunc7 := io.func7_in

  io.ctrl_MemWr_out := Reg_Ctrl_MemW@@r
  Reg_Ctrl_MemWr := io.ctrl_MemWr_in

  io.ctrl_MemRd_out := Reg_Ctrl_MemRd
  Reg_Ctrl_MemRd := io.ctrl_MemRd_in

  io.ctrl_Branch_out := Reg_Ctrl_Branch
  Reg_Ctrl_Branch := io.ctrl_Branch_in

  io.ctrl_RegWr_out := Reg_Ctrl_RegWr
  Reg_Ctrl_RegWr := io.ctrl_RegWr_in

  io.ctrl_MemtoReg_out := Reg_Ctrl_MemtoReg
  Reg_Ctrl_MemtoReg := io.ctrl_MemtoReg_in

  io.ctrl_ALUOP_out := Reg_Ctrl_AluOp
  Reg_Ctrl_AluOp := io.ctrl_ALUOP_in

  io.ctrl_OpA_sel_out := Reg_Ctrl_OpA
  Reg_Ctrl_OpA := io.ctrl_OpA_sel_in

  io.ctrl_OpB_sel_out := Reg_Ctrl_OpB
  Reg_Ctrl_OpB := io.ctrl_OpB_sel_in

  io.ctrl_nextPc_sel_out := Reg_Ctrl_nextPc
  Reg_Ctrl_nextPc := io.ctrl_nextPc_sel_in
}


```



#### Error stacktrace:

```
scala.reflect.api.Symbols$SymbolApi.asMethod(Symbols.scala:240)
	scala.reflect.api.Symbols$SymbolApi.asMethod$(Symbols.scala:234)
	scala.reflect.internal.Symbols$SymbolContextApiImpl.asMethod(Symbols.scala:100)
	scala.tools.nsc.typechecker.ContextErrors$TyperContextErrors$TyperErrorGen$.MissingArgsForMethodTpeError(ContextErrors.scala:682)
	scala.tools.nsc.typechecker.Typers$Typer.cantAdapt$1(Typers.scala:913)
	scala.tools.nsc.typechecker.Typers$Typer.instantiateToMethodType$1(Typers.scala:944)
	scala.tools.nsc.typechecker.Typers$Typer.adapt(Typers.scala:1225)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:5794)
	scala.tools.nsc.typechecker.Typers$Typer.typedDefDef(Typers.scala:5996)
	scala.tools.nsc.typechecker.Typers$Typer.typed1(Typers.scala:5699)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:5780)
	scala.tools.nsc.typechecker.Typers$Typer.typedStat$1(Typers.scala:5844)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedStats$6(Typers.scala:3290)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedStats$6$adapted(Typers.scala:3287)
	scala.Option$WithFilter.foreach(Option.scala:407)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedStats$4(Typers.scala:3287)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedStats$4$adapted(Typers.scala:3285)
	scala.reflect.internal.Scopes$Scope.foreach(Scopes.scala:435)
	scala.tools.nsc.typechecker.Typers$Typer.addSynthetics$1(Typers.scala:3285)
	scala.tools.nsc.typechecker.Typers$Typer.typedStats(Typers.scala:3349)
	scala.tools.nsc.typechecker.Typers$Typer.typedTemplate(Typers.scala:2019)
	scala.tools.nsc.typechecker.Typers$Typer.typedClassDef(Typers.scala:1832)
	scala.tools.nsc.typechecker.Typers$Typer.typed1(Typers.scala:5700)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:5780)
	scala.tools.nsc.typechecker.Typers$Typer.typedStat$1(Typers.scala:5844)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedStats$10(Typers.scala:3337)
	scala.tools.nsc.typechecker.Typers$Typer.typedStats(Typers.scala:3337)
	scala.tools.nsc.typechecker.Typers$Typer.typedBlock(Typers.scala:2497)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typed1$103(Typers.scala:5709)
	scala.tools.nsc.typechecker.Typers$Typer.typedOutsidePatternMode$1(Typers.scala:500)
	scala.tools.nsc.typechecker.Typers$Typer.typed1(Typers.scala:5744)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:5780)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedArg$1(Typers.scala:3355)
	scala.tools.nsc.typechecker.Typers$Typer.typedArg(Typers.scala:491)
	scala.tools.nsc.typechecker.Typers$Typer.typedArgToPoly$1(Typers.scala:3745)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$doTypedApply$32(Typers.scala:3753)
	scala.tools.nsc.typechecker.Typers$Typer.handlePolymorphicCall$1(Typers.scala:3753)
	scala.tools.nsc.typechecker.Typers$Typer.doTypedApply(Typers.scala:3764)
	scala.tools.nsc.typechecker.Typers$Typer.normalTypedApply$1(Typers.scala:4909)
	scala.tools.nsc.typechecker.Typers$Typer.typedApply$1(Typers.scala:4918)
	scala.tools.nsc.typechecker.Typers$Typer.typed1(Typers.scala:5734)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:5780)
	scala.tools.nsc.typechecker.Typers$Typer.computeType(Typers.scala:5855)
	scala.tools.nsc.typechecker.Namers$Namer.assignTypeToTree(Namers.scala:1114)
	scala.tools.nsc.typechecker.Namers$Namer.valDefSig(Namers.scala:1733)
	scala.tools.nsc.typechecker.Namers$Namer.memberSig(Namers.scala:1919)
	scala.tools.nsc.typechecker.Namers$Namer.typeSig(Namers.scala:1870)
	scala.tools.nsc.typechecker.Namers$Namer$ValTypeCompleter.completeImpl(Namers.scala:945)
	scala.tools.nsc.typechecker.Namers$LockingTypeCompleter.complete(Namers.scala:2081)
	scala.tools.nsc.typechecker.Namers$LockingTypeCompleter.complete$(Namers.scala:2079)
	scala.tools.nsc.typechecker.Namers$TypeCompleterBase.complete(Namers.scala:2074)
	scala.reflect.internal.Symbols$Symbol.completeInfo(Symbols.scala:1542)
	scala.reflect.internal.Symbols$Symbol.info(Symbols.scala:1514)
	scala.reflect.internal.Symbols$Symbol.initialize(Symbols.scala:1698)
	scala.tools.nsc.typechecker.Typers$Typer.typed1(Typers.scala:5403)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:5780)
	scala.tools.nsc.typechecker.Typers$Typer.typedStat$1(Typers.scala:5844)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedStats$10(Typers.scala:3337)
	scala.tools.nsc.typechecker.Typers$Typer.typedStats(Typers.scala:3337)
	scala.tools.nsc.typechecker.Typers$Typer.typedTemplate(Typers.scala:2019)
	scala.tools.nsc.typechecker.Typers$Typer.typedClassDef(Typers.scala:1832)
	scala.tools.nsc.typechecker.Typers$Typer.typed1(Typers.scala:5700)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:5780)
	scala.tools.nsc.typechecker.Typers$Typer.typedStat$1(Typers.scala:5844)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedStats$10(Typers.scala:3337)
	scala.tools.nsc.typechecker.Typers$Typer.typedStats(Typers.scala:3337)
	scala.tools.nsc.typechecker.Typers$Typer.typedPackageDef$1(Typers.scala:5410)
	scala.tools.nsc.typechecker.Typers$Typer.typed1(Typers.scala:5703)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:5780)
	scala.tools.nsc.typechecker.Analyzer$typerFactory$TyperPhase.apply(Analyzer.scala:116)
	scala.tools.nsc.Global$GlobalPhase.applyPhase(Global.scala:453)
	scala.tools.nsc.interactive.Global$TyperRun.$anonfun$applyPhase$1(Global.scala:1340)
	scala.tools.nsc.interactive.Global$TyperRun.applyPhase(Global.scala:1340)
	scala.tools.nsc.interactive.Global$TyperRun.typeCheck(Global.scala:1333)
	scala.tools.nsc.interactive.Global.typeCheck(Global.scala:665)
	scala.meta.internal.pc.WithCompilationUnit.<init>(WithCompilationUnit.scala:22)
	scala.meta.internal.pc.WithSymbolSearchCollector.<init>(PcCollector.scala:348)
	scala.meta.internal.pc.PcDocumentHighlightProvider.<init>(PcDocumentHighlightProvider.scala:12)
	scala.meta.internal.pc.ScalaPresentationCompiler.$anonfun$documentHighlight$1(ScalaPresentationCompiler.scala:432)
```
#### Short summary: 

scala.ScalaReflectionException: value rd_sel_in is not a method