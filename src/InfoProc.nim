import std/[os, strutils, strformat]

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

proc info*(entry: string) {.noreturn.} =
  var
    info: FileInfo
    str: string
    size: string
    tmp: seq[string]

  try:
    info = getFileInfo(expandTilde(entry), followSymlink = false)

  except OSError:
    stderr.writeLine("\n", red, "ERROR", reset, ": ", "'", blue, entry, reset, "'", yellow, " is not a valid file or directory", reset)
    stderr.flushFile
    quit(1)

  size = "{info.size.float / 1000:2.1f}KB".fmt

  str.add([pcFile: '-', 'l', pcDir: 'd', 'l'][info.kind])

  for pos, perm in [fpUserRead, fpUserWrite, fpUserExec, fpGroupRead, fpGroupWrite, fpGroupExec, fpOthersRead, fpOthersWrite, fpOthersExec]:
    str.add(if perm in info.permissions: "rwx"[pos mod 3] else: '-')

  stdout.writeLine("\n{blue}Entry Info{reset} {yellow}for{reset} '{green}{entry}{reset}':\n".fmt & "‾".repeat(17+entry.len))
  stdout.writeLine(" {red}Entry{reset}: {green}{entry}{reset}".fmt)
  stdout.writeLine(" {red}Type{reset}: ".fmt, if info.kind == pcDir: "{blue}Folder{reset}".fmt elif info.kind == pcLinkToDir: "{yellow}Symlink->Folder{reset}".fmt elif info.kind == pcFile: "{blue}File{reset}".fmt else: "{yellow}Symlink->File{reset}".fmt)
  stdout.writeLine(" {red}Permissions{reset}: {green}{str}{reset}".fmt)
  stdout.writeLine(" {red}Size{reset}: {cyan}{size}{reset}".fmt)
  stdout.flushFile
  quit(0)

setControlCHook(sigintHandler)
