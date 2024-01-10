import os, strformat

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
  stdout.flushFile
  quit(0)

const
  red: string = "\e[1;31m"
  green: string = "\e[1;32m"
  yellow: string = "\e[1;33m"
  reset: string = "\e[0m"

proc join*(files: seq[string], outfile: string = "") {.noreturn.} =
  var
    contents: string
    newfile: File

  if files.len > 0 and outfile.len == 0:
    for f in files:
      if fileExists(expandTilde(f)):
        contents &= readFile(expandTilde(f))

      else:
        stderr.writeLine("\n{red}ERROR{reset}: '{green}{f}{reset}' {yellow}doesn't exist or can't be opened{reset}".fmt)
        stderr.flushFile
        discard f
        quit(1)

    newfile = open(expandTilde(files[0]), fmWrite)
    newfile.write(contents)
    newfile.close()
    quit(0)

  elif files.len > 0 and outfile.len > 0:
    for f in files:
      if fileExists(expandTilde(f)):
        contents &= readFile(expandTilde(f))

      else:
        stderr.writeLine("\n{red}ERROR{reset}: '{green}{f}{reset}' {yellow}doesn't exist or can't be opened{reset}".fmt)
        stderr.flushFile
        discard f
        quit(1)

    if fileExists(expandTilde(outfile)):
      newfile = open(expandTilde(outfile), fmAppend)

    else:
      newfile = open(expandTilde(outfile), fmWrite)

    newfile.write(contents)
    newfile.close()
    quit(0)

  else:
    stderr.writeLine("\n{red}ERROR{reset}: {yellow}an unexpected error ocurred{reset}".fmt)
    stderr.flushFile
    quit(1)

setControlCHook(sigintHandler)
