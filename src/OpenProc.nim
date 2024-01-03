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

proc Open*(Open: string = "", Read: string = "", Write: string = "", Append: string = "") {.noReturn.} =
  var
    fileContents: string
    newfile: File

  if Open.len == 0 and Read.len > 0 and Write.len == 0 and Append.len == 0:
    if fileExists(expandTilde(Read)):
      fileContents = readFile(expandTilde(Read))
      stdout.write(ReplaceProc.Replace(fileContents))
      stdout.flushFile
      quit(0)

    else:
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}the file{reset} '{green}{Read}{reset}' {yellow}doesn't exist or can't be opened{reset}\n".fmt)
      stderr.flushFile
      quit(1)

  elif Open.len > 0 and Read.len == 0 and Write.len == 0 and Append.len > 0:
    if Open.endsWith("stdin"):
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}cannot open file{reset} '{green}{Open}{reset}'".fmt)
      stderr.flushFile
      quit(1)

    elif fileExists(expandTilde(Open)):
      newfile = open(expandTilde(Open), fmAppend)
      newfile.write(ReplaceProc.Replace(Append))
      newfile.close()
      quit(0)

    else:
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}the file{reset} '{green}{Open}{reset}' {yellow}doesn't exist or can't be opened{reset}\n".fmt)
      stderr.flushFile
      quit(1)

  elif Open.len > 0 and Read.len == 0 and Write.len > 0 and Append.len == 0:
    if Open.endsWith("stdin"):
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}cannot open file{reset} '{green}{Open}{reset}'".fmt)
      stderr.flushFile
      quit(1)

    else:
      newfile = open(expandTilde(Open), fmWrite)
      newfile.write(ReplaceProc.Replace(Write))
      newfile.close()
      quit(0)

  elif Open.len == 0 and Read.len > 0 and Write.len > 0 and Append.len == 0:
    if fileExists(expandTilde(Read)):
      fileContents = readFile(expandTilde(Read))
      newfile = open(expandTilde(Write), fmWrite)
      newfile.write(fileContents)
      newfile.close()
      quit(0)

    else:
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}the file{reset} '{green}{Read}{reset}' {yellow}doesn't exist or can't be opened{reset}\n".fmt)
      stderr.flushFile
      quit(1)

  else:
    stderr.writeLine("\n{red}ERROR{reset}: {yellow}an unexpected error occured{reset}\n".fmt)
    stderr.flushFile
    quit(1)

setControlCHook(sigintHandler)
