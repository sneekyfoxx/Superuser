import os, posix_utils, strutils, strformat, algorithm, terminal

proc sigintHandler() {.noconv.} =
  showCursor()
  stdout.flushFile
  quit(0)

proc list*(directory: string = "./", match: string = "", rate: int = 0) {.noreturn.} =

  const
    red: string = "\e[1;31m"
    green: string = "\e[1;32m"
    yellow: string = "\e[1;33m"
    blue: string = "\e[1;34m"
    magenta: string = "\e[1;35m"
    cyan: string = "\e[1;36m"
    reset: string = "\e[0m"

  var
    entries: seq[string]
    info: seq[FileInfo]
    str: string
    size: string
    stream: string
    index: int = 0
    user: string
    group: string
    linkcount: int
    nomatch: bool = true
    fileperms: seq[FilePermission]

  if not dirExists(expandTilde(directory)):
    stderr.writeLine("\n", red, "ERROR", ": ", reset, "'", blue, directory, reset, "' ", yellow, "is not a directory", reset)
    stderr.flushFile
    quit(1)

  fileperms = @[fpUserRead, fpUserWrite, fpUserExec, fpGroupRead, fpGroupWrite, fpGroupExec, fpOthersRead, fpOthersWrite, fpOthersExec]
  stream &= "\n{blue}Directory Entries{reset} {yellow}for{reset} '{green}{directory}{reset}':\n".fmt & "‾".repeat(24+directory.len) & "\n"

  for entry in walkDir(expandTilde(directory), relative = false, checkdir = false):
    entries.add(entry.path)

  for entry in sorted(entries, Ascending):
    try:
     info.add(getFileInfo(expandTilde(entry), followSymlink = false))

    except OSError:
      continue

  while index < info.len:
    try:
      var
        fileinfo: FileInfo = info[index]
        entry: string = entries[index].split("/")[^1]

      size = "{fileinfo.size.float / 1000:2.3f} KB".fmt

      str.add([pcFile: '-', 'l', pcDir: 'd', 'l'][fileinfo.kind])

      for pos, perm in fileperms:
        str.add(if perm in fileinfo.permissions: "rwx"[pos mod 3] else: '-')

      linkcount = stat(expandTilde(entries[index])).st_nlink.int

      if stat(expandTilde(entries[index])).st_uid == 0:
        user = "superuser"

      if stat(expandTilde(entries[index])).st_uid >= 1000:
        user = getEnv("USER")

      if stat(expandTilde(entries[index])).st_gid == 0:
        group = "superuser"

      if stat(expandTilde(entries[index])).st_gid >= 1000:
        group = getEnv("USER")

      if fileinfo.kind == pcDir:
        if match.len != 0 and match == entry:
          nomatch = false
          stream &= " {red}Entry{reset}: {green}{entry}{reset}".fmt
          stream &= "\n {red}Type{reset}: {blue}Folder{reset}".fmt
          stream &= "\n {red}Owner{reset}: {magenta}{user}{reset}".fmt
          stream &= "\n {red}Group{reset}: {magenta}{group}{reset}".fmt
          stream &= "\n {red}Size{reset}: {cyan}{size}{reset}".fmt
          stream &= "\n {red}LinkCount{reset}: {cyan}{linkcount}{reset}".fmt
          stream &= "\n {red}Permissions{reset}: {green}{str}{reset}\n\n".fmt
          stdout.write(stream)
          stdout.flushFile
          break

        elif match.len != 0 and match != entry:
          str = ""
          index.inc()
          continue

        else:
          stream &= " {red}Entry{reset}: {green}{entry}{reset}".fmt
          stream &= "\n {red}Type{reset}: {blue}Folder{reset}".fmt
          stream &= "\n {red}Owner{reset}: {magenta}{user}{reset}".fmt
          stream &= "\n {red}Group{reset}: {magenta}{group}{reset}".fmt
          stream &= "\n {red}Size{reset}: {cyan}{size}{reset}".fmt
          stream &= "\n {red}LinkCount{reset}: {cyan}{linkcount}{reset}".fmt
          stream &= "\n {red}Permissions{reset}: {green}{str}{reset}\n\n".fmt

      elif fileinfo.kind == pcLinkToDir:
        if match.len != 0 and match == entry:
          nomatch = false
          stream &= " {red}Entry{reset}: {green}{entry}{reset}".fmt
          stream &= "\n {red}Type{reset}: {blue}Symlink->Folder{reset}".fmt
          stream &= "\n {red}Owner{reset}: {magenta}{user}{reset}".fmt
          stream &= "\n {red}Group{reset}: {magenta}{group}{reset}".fmt
          stream &= "\n {red}Size{reset}: {cyan}{size}{reset}".fmt
          stream &= "\n {red}LinkCount{reset}: {cyan}{linkcount}{reset}".fmt
          stream &= "\n {red}Permissions{reset}: {green}{str}{reset}\n\n".fmt
          stdout.write(stream)
          stdout.flushFile
          break

        elif match.len != 0 and match != entry:
          str = ""
          index.inc()
          continue

        else:
          stream &= " {red}Entry{reset}: {green}{entry}{reset}".fmt
          stream &= "\n {red}Type{reset}: {blue}Symlink->Folder{reset}".fmt
          stream &= "\n {red}Owner{reset}: {magenta}{user}{reset}".fmt
          stream &= "\n {red}Group{reset}: {magenta}{group}{reset}".fmt
          stream &= "\n {red}Size{reset}: {cyan}{size}{reset}".fmt
          stream &= "\n {red}LinkCount{reset}: {cyan}{linkcount}{reset}".fmt
          stream &= "\n {red}Permissions{reset}: {green}{str}{reset}\n\n".fmt

      elif fileinfo.kind == pcLinkToFile:
        if match.len != 0 and match == entry:
          nomatch = false
          stream &= " {red}Entry{reset}: {green}{entry}{reset}".fmt
          stream &= "\n {red}Type{reset}: {blue}Symlink->File{reset}".fmt
          stream &= "\n {red}Owner{reset}: {magenta}{user}{reset}".fmt
          stream &= "\n {red}Group{reset}: {magenta}{group}{reset}".fmt
          stream &= "\n {red}Size{reset}: {cyan}{size}{reset}".fmt
          stream &= "\n {red}LinkCount{reset}: {cyan}{linkcount}{reset}".fmt
          stream &= "\n {red}Permissions{reset}: {green}{str}{reset}\n\n".fmt
          stdout.write(stream)
          stdout.flushFile
          break

        elif match.len != 0 and match != entry:
          str = ""
          index.inc()
          continue

        else:
          stream &= " {red}Entry{reset}: {green}{entry}{reset}".fmt
          stream &= "\n {red}Type{reset}: {blue}Symlink->File{reset}".fmt
          stream &= "\n {red}Owner{reset}: {magenta}{user}{reset}".fmt
          stream &= "\n {red}Group{reset}: {magenta}{group}{reset}".fmt
          stream &= "\n {red}Size{reset}: {cyan}{size}{reset}".fmt
          stream &= "\n {red}LinkCount{reset}: {cyan}{linkcount}{reset}".fmt
          stream &= "\n {red}Permissions{reset}: {green}{str}{reset}\n\n".fmt

      else:
        if match.len != 0 and match == entry:
          nomatch = false
          stream &= " {red}Entry{reset}: {green}{entry}{reset}".fmt
          stream &= "\n {red}Type{reset}: {blue}File{reset}".fmt
          stream &= "\n {red}Owner{reset}: {magenta}{user}{reset}".fmt
          stream &= "\n {red}Group{reset}: {magenta}{group}{reset}".fmt
          stream &= "\n {red}Size{reset}: {cyan}{size}{reset}".fmt
          stream &= "\n {red}LinkCount{reset}: {cyan}{linkcount}{reset}".fmt
          stream &= "\n {red}Permissions{reset}: {green}{str}{reset}\n\n".fmt
          stdout.write(stream)
          stdout.flushFile
          break

        elif match.len != 0 and match != entry:
          str = ""
          index.inc()
          continue

        else:
          stream &= " {red}Entry{reset}: {green}{entry}{reset}".fmt
          stream &= "\n {red}Type{reset}: {blue}File{reset}".fmt
          stream &= "\n {red}Owner{reset}: {magenta}{user}{reset}".fmt
          stream &= "\n {red}Group{reset}: {magenta}{group}{reset}".fmt
          stream &= "\n {red}Size{reset}: {cyan}{size}{reset}".fmt
          stream &= "\n {red}LinkCount{reset}: {cyan}{linkcount}{reset}".fmt
          stream &= "\n {red}Permissions{reset}: {green}{str}{reset}\n\n".fmt

      stdout.write(stream)
      stdout.flushFile
      stream = ""

      if rate >= 0:
        sleep(rate)

      str = ""
      index.inc()

    except IndexDefect:
      break

  if match.len != 0 and nomatch == true:
    stdout.writeLine("\n{yellow}Warning{reset}: '{red}{match}{reset}' {yellow}wasn't found in{reset} '{green}{directory}{reset}'".fmt)
    stdout.flushFile
    quit(1)

  quit(0)

setControlCHook(sigintHandler)
