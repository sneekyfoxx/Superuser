import std/[os, strutils, strformat, times, terminal]

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
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

proc Find*(name: string = "", use: string = "/", mode: string = "strict", limit: int = 0, Write: string = "") {.noReturn.} =
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

  if name != "" and (name.startsWith("/") or name.endsWith("/")):
    stderr.writeLine("\n{red}ERROR{reset}: {yellow}found leading or trailing{reset} '{red}/{reset}'\n".fmt)
    stderr.flushFile()
    quit(1)

  elif name != "" and (name.startsWith("\\") or name.endsWith("\\")):
    stderr.writeLine("\n{red}ERROR{reset}: {yellow}found leading or trailing{reset} '{red}\\{reset}'\n".fmt)
    stderr.flushFile()
    quit(0)

  stdout.hideCursor()
  searchStartTime = cpuTime()

  for entry in walkDirRec(expandTilde(use), yieldFilter={pcFile, pcDir, pcLinkToFile, pcLinkToDir}, relative = false, checkdir = false):
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

          if Write.len == 0:
            stdout.writeLine("<", blue, "Folder", reset, "> ", green, "Path", reset, ": ", blue, entry & "/", reset, "\n")
            stdout.flushFile

          if limit > 0 and counter == limit:
            break

      elif info == pcLinkToDir:
        if (mode == "strict" and entryDirName.endsWith(strictDirName)) or (mode == "passive" and entryDirName.contains(passiveDirName)):
          counter.inc()
          dirsFound.add(entry & "/")

          if Write.len == 0:
            stdout.writeLine("<", blue, "Symlink->Folder", reset, "> ", green, "Path", reset, ": ", blue, entry & "/", reset, "\n")
            stdout.flushFile

          if limit > 0 and counter == limit:
            break

      elif info == pcFile:
        if (mode == "strict" and entryFileName.endsWith(strictFileName)) or (mode == "passive" and entryFileName.contains(passiveFileName)):
          counter.inc()
          filesFound.add(entry)

          if Write.len == 0:
            stdout.writeLine("<", blue, "File", reset, "> ", green, "Path", reset, ": ", blue, entry, reset, "\n")
            stdout.flushFile

          if limit > 0 and counter == limit:
            break

      elif info == pcLinkToFile:
        if (mode == "strict" and entryFileName.endsWith(strictFileName)) or (mode == "passive" and entryFileName.contains(passiveFileName)):
          counter.inc()
          filesFound.add(entry)

          if Write.len == 0:
            stdout.writeLine("<", blue, "Symlink->File", reset, "> ", green, "Path", reset, ": ", blue, entry, reset, "\n")
            stdout.flushFile

          if limit > 0 and counter == limit:
            break

    except OSError:
      continue

  searchEndTime = "{cpuTime() - searchStartTime:.2f}".fmt
  eraseLine()
  stdout.styledWriteLine("{yellow}Searching{reset}: {green}Done!{reset}".fmt)
  cursorUp(1)

  var found: string = intToStr(dirsFound.len + filesFound.len)

  if Write.len == 0:
    sleep(2000)
    eraseLine()
    stdout.writeLine("\n{green}Found{reset} {cyan}{found}{reset} paths in {green}{searchEndTime}{reset} seconds".fmt)
    stdout.flushFile()
    stdout.showCursor()
    quit(0)
  
  else:
    sleep(1000)
    if fileExists(expandTilde("./"&Write)):
      file = open(expandTilde("./"&Write), fmAppend)

    else:
      file = open(expandTilde("./"&Write), fmAppend)

    if parseInt(found) > 0:
      let data: seq[string] = dirsFound & filesFound
      dot = "."

      writeStartTime = cpuTime()

      for value in data:
        var filename: string = value & "\n"
        stdout.writeLine("\n{yellow}Writing{reset}{blue}{dot}{reset}".fmt)
        file.write(filename)
        cursorUp(1)
        eraseLine()
        cursorUp(1)
        sleep(1000)

        if dot.len == 20:
          dot = "."

      stdout.writeLine("\n{yellow}Writing{reset}: {green}Done!{reset}".fmt)
      cursorUp(2)
      sleep(2000)
      eraseLine()
      file.close()

      writeEndTime = "{cpuTime() - writeStartTime:.2f}".fmt
      stdout.writeLine("\n{green}Wrote{reset} {cyan}{found}{reset} paths to '{yellow}{Write}{reset}' in {green}{writeEndTime}{reset} seconds".fmt)
      stdout.flushFile()
      showCursor()
      quit(1)

    else:
      writeEndTime = "{cpuTime() - writeStartTime:.2f}".fmt
      stdout.writeLine("\n{green}Wrote{reset} {cyan}{found}{reset} paths to '{yellow}{Write}{reset}' in {green}{writeEndTime}{reset} seconds".fmt)
      stdout.flushFile()
      showCursor()
      quit(0)

setControlCHook(sigintHandler)
