import os, strutils, strformat, terminal
import ReplaceProc

proc sigintHandler() {.noconv.} =
  showCursor()
  stdout.flushFile
  quit(0)

const
  red: string = "\e[1;31m"
  green: string = "\e[1;32m"
  yellow: string = "\e[1;33m"
  cyan: string = "\e[1;36m"
  reset: string = "\e[0m"

proc echo*(text: string = "", write: string = "") {.noreturn.} =
  var newfile: File

  if text.len >= 1 and write.len == 0:
    stdout.write(ReplaceProc.replace(text))
    stdout.flushFile
    quit(0)

  elif text.len > 0 and write.len > 0:
    if write.endsWith("stdin"):
      stderr.write("\n{red}ERROR{reset}: {yellow}cannot open file{reset} '{green}{write}{reset}'".fmt)
      stderr.flushFile
      quit(1)

    elif fileExists(expandTilde(write)):
      newfile = open(expandTilde(write), fmAppend)
      newfile.write(ReplaceProc.replace(text))
      newfile.close()
      quit(0)

    else:
      newfile = open(expandTilde(write), fmWrite)
      newfile.write(ReplaceProc.replace(text))
      newfile.close()
      quit(0)

  else:
    stderr.writeLine("\n{red}ERROR{reset}: '{cyan}echo{reset}' {yellow}needs text of length >= 1{reset}\n".fmt)
    stderr.flushFile
    quit(1)

setControlCHook(sigintHandler)
