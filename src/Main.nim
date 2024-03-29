import os, terminal
import ArgumentsProc

proc sigintHandler() {.noconv.} =
  showCursor()
  stdout.flushFile
  quit(0)

proc main {.noreturn.} =

  if isatty(stdin) and isatty(stdout):
     ArgumentsProc.arguments(commandLineParams())

  else:
    quit(1)

setControlCHook(sigintHandler)
main()
