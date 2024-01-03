import std/os
import ProcessArgumentsProc

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
  stdout.flushFile
  quit(0)

proc main {.noReturn.} =
  ProcessArgumentsProc.ProcessArguments(commandLineParams())

setControlCHook(sigintHandler)
main()
