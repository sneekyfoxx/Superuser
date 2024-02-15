import os, strutils, strformat, times, terminal

proc sigintHandler() {.noconv.} =
  showCursor()
  stdout.flushFile
  showCursor()
  quit(0)

const
  red: string = "\e[1;31m"
  green: string = "\e[1;32m"
  yellow: string = "\e[1;33m"
  blue: string = "\e[1;34m"
  cyan: string = "\e[1;36m"
  reset: string = "\e[0m"

proc search*(path: string = "/", name: string = "", mode: string = "strict", limit: int = 0, outfile: string = "") {.noreturn.} =
  var
    dirsFound: seq[string]
    filesFound: seq[string]
    file: File
    searchStartTime: float
    searchEndTime: string
    writeStartTime: float
    writeEndTime: string
    info: PathComponent
    entryDirName: string
    entryFileName: string
    strictDirName: string
    passiveDirName: string
    strictFileName: string
    passiveFileName: string
    counter: int
    dot: string = "."

  if name != "" and name.contains({'/', '\\'}):
    stderr.writeLine("\n{red}ERROR{reset}: {yellow}name cannot contain forward or back slashes{reset}\n".fmt)
    stderr.flushFile()
    quit(1)

  stdout.hideCursor()
  searchStartTime = cpuTime()

  for entry in walkDirRec(expandTilde(path), yieldFilter={pcFile, pcDir, pcLinkToFile, pcLinkToDir}, relative = false, checkdir = false):
    stdout.writeLine("{yellow}Searching for{reset} '{blue}{name}{reset}': {blue}{dot}{reset}".fmt)
    stdout.flushFile
    cursorUp(1)
    dot &= "."

    if dot.len == 20:
      dot = "."
      eraseLine()

    try:
      info = getFileInfo(expandTilde(entry), followSymlink = false).kind
      entryDirName = "{entry}/".fmt
      strictDirName = "/{name}/".fmt
      passiveDirName = "/{name}".fmt
      entryFileName = entry
      strictFileName = "/{name}".fmt
      passiveFileName = "{name}".fmt

      if info == pcDir:
        if (mode == "strict" and entryDirName.endsWith(strictDirName)) or (mode == "passive" and entryDirName.contains(passiveDirName)):
          counter.inc()
          dirsFound.add(entry & "/")

          if outfile.len == 0:
            stdout.writeLine("<", blue, "Folder", reset, "> ", green, "Path", reset, ": ", blue, entry & "/", reset, "\n")
            stdout.flushFile

          if limit > 0 and counter == limit:
            break

      elif info == pcLinkToDir:
        if (mode == "strict" and entryDirName.endsWith(strictDirName)) or (mode == "passive" and entryDirName.contains(passiveDirName)):
          counter.inc()
          dirsFound.add(entry & "/")

          if outfile.len == 0:
            stdout.writeLine("<", blue, "Symlink->Folder", reset, "> ", green, "Path", reset, ": ", blue, entry & "/", reset, "\n")
            stdout.flushFile

          if limit > 0 and counter == limit:
            break

      elif info == pcFile:
        if (mode == "strict" and entryFileName.endsWith(strictFileName)) or (mode == "passive" and entryFileName.contains(passiveFileName)):
          counter.inc()
          filesFound.add(entry)

          if outfile.len == 0:
            stdout.writeLine("<", blue, "File", reset, "> ", green, "Path", reset, ": ", blue, entry, reset, "\n")
            stdout.flushFile

          if limit > 0 and counter == limit:
            break

      elif info == pcLinkToFile:
        if (mode == "strict" and entryFileName.endsWith(strictFileName)) or (mode == "passive" and entryFileName.contains(passiveFileName)):
          counter.inc()
          filesFound.add(entry)

          if outfile.len == 0:
            stdout.writeLine("<", blue, "Symlink->File", reset, "> ", green, "Path", reset, ": ", blue, entry, reset, "\n")
            stdout.flushFile

          if limit > 0 and counter == limit:
            break

    except OSError:
      continue

  searchEndTime = "{cpuTime() - searchStartTime:.2f}".fmt

  var found: string = intToStr(dirsFound.len + filesFound.len)

  if outfile.len == 0:
    eraseLine()
    stdout.writeLine("\n{green}Found{reset} {cyan}{found}{reset} paths in {green}{searchEndTime}{reset} seconds".fmt)
    stdout.flushFile()
    stdout.showCursor()
    quit(0)
  
  else:
    if fileExists(expandTilde("./"&outfile)):
      file = open(expandTilde("./"&outfile), fmAppend)

    else:
      file = open(expandTilde("./"&outfile), fmAppend)

    if parseInt(found) > 0:
      let data: seq[string] = dirsFound & filesFound
      dot = "."

      writeStartTime = cpuTime()

      for value in data:
        var filename: string = value & "\n"
        stdout.writeLine("{yellow}Writing to{reset} '{blue}{outfile}{reset}': {blue}{dot}{reset}".fmt)
        cursorUp(1)
        eraseLine()

        if dot.len == 20:
          dot = "."

        else:
          dot &= "."

        file.write(filename)
      file.close()

      writeEndTime = "{cpuTime() - writeStartTime:.2f}".fmt
      stdout.writeLine("\n{green}Wrote{reset} {cyan}{found}{reset} paths to '{yellow}{outfile}{reset}' in {green}{writeEndTime}{reset} seconds".fmt)
      stdout.flushFile()
      showCursor()
      quit(1)

    else:
      writeEndTime = "{cpuTime() - writeStartTime:.2f}".fmt
      stdout.writeLine("\n{green}Wrote{reset} {cyan}{found}{reset} paths to '{yellow}{outfile}{reset}' in {green}{writeEndTime}{reset} seconds".fmt)
      stdout.flushFile()
      showCursor()
      quit(0)

setControlCHook(sigintHandler)
