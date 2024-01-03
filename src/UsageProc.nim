const
  red: string = "\e[1;31m"
  green: string = "\e[1;32m"
  magenta: string = "\e[1;35m"
  cyan: string = "\e[1;36m"
  white: string = "\e[1;97m"
  reset: string = "\e[0m"

proc Usage* {.noReturn.} =
  stdout.writeLine(red, "\n―――――――――――――――――――――――――――――――――――――――――――", reset, "{", magenta, "superuser", reset, "}", red, "―――――――――――――――――――――――――――――――――――――――――――", reset)
  stdout.flushFile

  stdout.writeLine("\n", cyan, "Command Line Usage", reset, "\n‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾")
  stdout.flushFile

  stdout.writeLine("\n", white, " 1).  ", cyan, "actions", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 2).  ", cyan, "usage", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 3).  ", cyan, "echo", reset, ":", green, "text", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 4).  ", cyan, "entries", reset, "[:", green, "directory", reset, "]")
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 5).  ", cyan, "entrycount", reset, "[:", green, "directory", reset, "]")
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 6).  ", cyan, "entryinfo", reset, ":", green, "entry", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 7).  ", cyan, "find", reset, ":", green, "name", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 8).  ", cyan, "join", reset, ":", green, "file1", reset, ",", green, "file2", reset, "[,", green, "...", reset, "]")
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 9).  ", cyan, "read", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 10).  ", cyan, "echo", reset, ":", green, "text   ", reset, cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 11).  ", cyan, "entries", reset, "[:", green, "directory", reset, "]   ", cyan, "match", reset, ":", green, "name", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 12).  ", cyan, "entries", reset, "[:", green, "directory", reset, "]   ", cyan, "yield", reset, ":", green, "number", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 13). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "use", reset, ":", green, "path", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 14). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "mode", reset, ":[", green, "passive", reset, "|", green, "strict", reset, "]")
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 15). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "limit", reset, ":", green, "number", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 16). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 17). ", cyan, "open", reset, ":", green, "file   ", reset, cyan, "append", reset, ":", green, "text", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 18). ", cyan, "open", reset, ":", green, "file   ", reset, cyan, "write", reset, ":", green, "text", reset)
  stdout.flushFile

  stdout.write("\n\n", white, " 19). ", cyan, "join", reset, ":", green, "file1", reset, ",", green, "file2", reset, "[,", green, "...", reset, "]   ")
  stdout.write(cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 20). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "use", reset, ":", green, "path   ", reset)
  stdout.write(cyan, "mode", reset, ":[", green, "passive", reset, "|", green, "strict", reset, "]")
  stdout.flushFile

  stdout.write("\n\n\n", white, " 21). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "use", ":", green, "path   ", reset)
  stdout.write(cyan, "limit", reset, ":", green, "number", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 22). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "use", ":", green, "path   ", reset)
  stdout.write(cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 23). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "mode", reset, ":[", green, "passive", reset, "|", green, "strict", reset, "]   ")
  stdout.write(cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 24). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "limit", ":", green, "number   ", reset)
  stdout.write(cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 25). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "use", reset, ":", green, "path   ", reset)
  stdout.write(cyan, "mode", reset, ":[", green, "passive", reset, "|", green, "strict", reset, "]   ", cyan, "limit", reset, ":", green, "number", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 26). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "use", reset, ":", green, "path   ", reset)
  stdout.write(cyan, "mode", reset, ":[", green, "passive", reset, "|", green, "strict", reset, "]   ", cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 27). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "use", reset, ":", green, "path   ", reset)
  stdout.write(cyan, "limit", reset, ":", green, "number   ", reset, cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 28). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "mode", reset, ":", green, "mode   ", reset)
  stdout.write(cyan, "limit", reset, ":", green, "number   ", reset, cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 29). ", cyan, "find", reset, ":", green, "name   ", reset, cyan, "use", reset, ":", green, "path   ", reset)
  stdout.write(cyan, "mode", reset, ":[", green, "passive", reset, "|", green, "strict", reset, "]   ", cyan, "limit", reset, ":", green, "number   ", reset)
  stdout.write(cyan, "write", reset, ":", green, "file", reset, "\n")
  stdout.flushFile

  stdout.writeLine(red, "\n―――――――――――――――――――――――――――――――――――――――――――", reset, "{", magenta, "superuser", reset, "}", red, "―――――――――――――――――――――――――――――――――――――――――――", reset)
  stdout.flushFile
  quit(0)
