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
  reset: string = "\e[0m"

proc open*(open: string = "", read: string = "", outfile: string = "", append: string = "") {.noreturn.} =
  var
    fileContents: string
    newfile: File

  if open.len == 0 and read.len > 0 and outfile.len == 0 and append.len == 0:
    if fileExists(expandTilde(read)):
      fileContents = readFile(expandTilde(read))
      stdout.write(ReplaceProc.replace(fileContents))
      stdout.flushFile
      quit(0)

    else:
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}the file{reset} '{green}{read}{reset}' {yellow}doesn't exist or can't be opened{reset}\n".fmt)
      stderr.flushFile
      quit(1)

  elif open.len > 0 and read.len == 0 and outfile.len == 0 and append.len > 0:
    if open.endsWith("stdin"):
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}cannot open file{reset} '{green}{open}{reset}'".fmt)
      stderr.flushFile
      quit(1)

    elif fileExists(expandTilde(open)):
      newfile = open(expandTilde(open), fmappend)
      newfile.write(ReplaceProc.replace(append))
      newfile.close()
      quit(0)

    else:
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}the file{reset} '{green}{open}{reset}' {yellow}doesn't exist or can't be opened{reset}\n".fmt)
      stderr.flushFile
      quit(1)

  elif open.len > 0 and read.len == 0 and outfile.len > 0 and append.len == 0:
    if open.endsWith("stdin"):
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}cannot open file{reset} '{green}{open}{reset}'".fmt)
      stderr.flushFile
      quit(1)

    else:
      newfile = open(expandTilde(open), fmWrite)
      newfile.write(ReplaceProc.replace(outfile))
      newfile.close()
      quit(0)

  elif open.len == 0 and read.len > 0 and outfile.len > 0 and append.len == 0:
    if fileExists(expandTilde(read)):
      fileContents = readFile(expandTilde(read))
      newfile = open(expandTilde(outfile), fmWrite)
      newfile.write(fileContents)
      newfile.close()
      quit(0)

    else:
      stderr.writeLine("\n{red}ERROR{reset}: {yellow}the file{reset} '{green}{read}{reset}' {yellow}doesn't exist or can't be opened{reset}\n".fmt)
      stderr.flushFile
      quit(1)

  else:
    stderr.writeLine("\n{red}ERROR{reset}: {yellow}an unexpected error occured{reset}\n".fmt)
    stderr.flushFile
    quit(1)

setControlCHook(sigintHandler)
