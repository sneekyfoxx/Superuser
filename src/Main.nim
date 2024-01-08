import std/os
import ProcessArgumentsProc

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
  stdout.flushFile
  quit(0)

proc main {.noreturn.} =
  ProcessArgumentsProc.processArguments(commandLineParams())

setControlCHook(sigintHandler)
main()
