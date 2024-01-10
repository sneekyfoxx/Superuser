import os, strutils, strformat, terminal

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
  stdout.flushFile
  quit(0)

const
  red: string = "\e[1;31m"
  green: string = "\e[1;32m"
  yellow: string = "\e[1;33m"
  blue: string = "\e[1;34m"
  cyan: string = "\e[1;36m"
  reset: string = "\e[0m"

proc count*(directory: string = getCurrentDir()) {.noreturn.} =
  var
    totalcounter: int = 0
    filecounter: int = 0
    filelinkcounter: int = 0
    dircounter: int = 0
    dirlinkcounter: int = 0

  if not dirExists(expandTilde(directory)):
    stderr.writeLine("\n", red, "ERROR", reset, ": ", "'", blue, directory, reset, "'", yellow, "is not a directory", reset)
    stderr.flushFile
    quit(1)

  stdout.write("\n")
  stdout.hideCursor()

  for entry in walkDirRec(expandTilde(directory), yieldFilter={pcFile, pcDir, pcLinkToFile, pcLinkToDir}, followFilter={pcDir}, relative = false, checkdir = false):
    var entryinfo: FileInfo = getFileInfo(expandTilde(entry), followSymlink=false) 
    
    stdout.writeLine("{yellow}Counting Entries in {reset}'{blue}{directory}{reset}': {cyan}{intToStr(totalcounter)}{reset}".fmt)
    cursorUp(1)
    eraseLine()
    
    if entryinfo.kind == pcFile and entryinfo.kind != pcLinkToFile:
      filecounter.inc()

    elif entryinfo.kind != pcFile and entryinfo.kind == pcLinkToFile:
      filelinkcounter.inc()

    elif entryinfo.kind == pcDir and entryinfo.kind != pcLinkToDir:
      dircounter.inc()

    elif entryinfo.kind != pcDir and entryinfo.kind == pcLinkToDir:
      dirlinkcounter.inc()
    
    totalcounter.inc()

  cursorUp(1)
  eraseLine()
  stdout.write("\n{blue}Entry Count{reset} {yellow}for{reset} '{green}{directory}{reset}':\n".fmt & "‾".repeat(18 + directory.len))
  stdout.write("\n {red}Files{reset}: {green}{intToStr(filecounter + filelinkcounter)}{reset}".fmt)
  stdout.write("\n {red}Directories{reset}: {green}{intToStr(dircounter + dirlinkcounter)}{reset}".fmt)
  stdout.write("\n {red}File Symlinks{reset}: {green}{intToStr(filelinkcounter)}{reset}".fmt)
  stdout.write("\n {red}Directory Symlinks{reset}: {green}{intToStr(dirlinkcounter)}{reset}".fmt)
  stdout.write("\n {yellow}Total{reset}: {green}{intToStr(totalcounter)}{reset}\n".fmt)
  stdout.flushFile
  stdout.showCursor()
  quit(0)

setControlCHook(sigintHandler)
