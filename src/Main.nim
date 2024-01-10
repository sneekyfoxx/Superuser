import std/os
import ArgumentsProc

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
  stdout.flushFile
  quit(0)

proc main {.noreturn.} =
  ArgumentsProc.arguments(commandLineParams())

setControlCHook(sigintHandler)
main()
