import std/[os, strutils, strformat]
import ReplaceProc

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
  stdout.flushFile
  quit(0)

const
  red: string = "\e[1;31m"
  green: string = "\e[1;32m"
  yellow: string = "\e[1;33m"
  reset: string = "\e[0m"

proc Echo*(text: string = "", Write: string = "") {.noReturn.} =
  var newfile: File

  if text.len > 0 and Write.len == 0:
    stdout.writeLine(ReplaceProc.Replace(text))
    stdout.flushFile
    quit(0)

  elif text.len > 0 and Write.len > 0:
    if Write.endsWith("stdin"):
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}cannot open file{reset} '{green}{Write}{reset}'".fmt)
      stderr.flushFile
      quit(1)

    elif fileExists(expandTilde(Write)):
      newfile = open(expandTilde(Write), fmAppend)
      newfile.write(ReplaceProc.Replace(text))
      newfile.close()
      quit(0)

    else:
      newfile = open(expandTilde(Write), fmWrite)
      newfile.write(ReplaceProc.Replace(text))
      newfile.close()
      quit(0)

  else:
    stderr.writeLine("\n{red}ERROR{reset}: {yellow}an unexpected error occured{reset}\n".fmt)
    stderr.flushFile
    quit(1)

setControlCHook(sigintHandler)
