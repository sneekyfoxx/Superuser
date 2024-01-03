import std/[os, strutils, strformat, terminal]

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
  stdout.flushFile
  quit(0)

const
  red: string = "\e[1;31m"
  yellow: string = "\e[1;33m"
  blue: string = "\e[1;34m"
  cyan: string = "\e[1;36m"
  reset: string = "\e[0m"

proc EntryCount*(directory: string = getCurrentDir()) {.noReturn.} =
  var
    counter: int

  if not dirExists(expandTilde(directory)):
    stderr.writeLine("\n", red, "ERROR", reset, ": ", "'", blue, directory, reset, "'", yellow, "is not a directory", reset)
    stderr.flushFile
    quit(1)

  stdout.write("\n")
  stdout.hideCursor()

  for entry in walkDirRec(expandTilde(directory), yieldFilter={pcFile, pcDir, pcLinkToFile, pcLinkToDir}, followFilter={pcDir}, relative = false, checkdir = false):
    counter.inc()
    stdout.writeLine("{yellow}Counting Entries in {reset}'{blue}{directory}{reset}': {cyan}{intToStr(counter)}{reset}".fmt)
    cursorUp(1)
    eraseLine()

  stdout.styledWriteLine("{yellow}Total Entries in {reset}'{blue}{directory}{reset}': {cyan}{intToStr(counter)}{reset}".fmt)
  stdout.flushFile
  stdout.showCursor()
  quit(0)

setControlCHook(sigintHandler)
