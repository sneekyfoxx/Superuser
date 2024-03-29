const
  green: string = "\e[1;32m"
  cyan: string = "\e[1;36m"
  white: string = "\e[1;97m"
  reset: string = "\e[0m"

proc usage* {.noreturn.} =

  stdout.writeLine("\n", cyan, "Command Line Usage", reset, "\n‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾")
  stdout.flushFile

  stdout.writeLine("\n", white, " 1). ", cyan, "actions", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 2). ", cyan, "usage", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 3). ", cyan, "echo", reset, ":", green, "text", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 4). ", cyan, "list", reset, "[:", green, "directory", reset, "]")
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 5). ", cyan, "count", reset, "[:", green, "directory", reset, "]")
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 6). ", cyan, "info", reset, ":", green, "entry", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 7). ", cyan, "join", reset, ":", green, "file1", reset, ",", green, "file2", reset, "[,", green, "...", reset, "]")
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 8). ", cyan, "read", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 9). ", cyan, "echo", reset, ":", green, "text   ", reset, cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 10). ", cyan, "list", reset, "[:", green, "directory", reset, "]   ", cyan, "match", reset, ":", green, "entry", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 11). ", cyan, "list", reset, "[:", green, "directory", reset, "]   ", cyan, "yield", reset, ":", green, "number", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 12). ", cyan, "open", reset, ":", green, "file   ", reset, cyan, "append", reset, ":", green, "text", reset)
  stdout.flushFile

  stdout.writeLine("\n\n", white, " 13). ", cyan, "open", reset, ":", green, "file   ", reset, cyan, "write", reset, ":", green, "text", reset)
  stdout.flushFile

  stdout.write("\n\n", white, " 14). ", cyan, "join", reset, ":", green, "file1", reset, ",", green, "file2", reset, "[,", green, "...", reset, "]   ")
  stdout.write(cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 15). ", cyan, "search", reset, "[:", green, "path", reset, "]   ", cyan, "match", reset, ":", green, "entry   ", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 16). ", cyan, "search", reset, "[:", green, "path", reset, "]   ", cyan, "match", reset, ":", green, "entry   ", reset)
  stdout.write(cyan, "mode", reset, ":[", green, "passive", reset, "|", green, "strict", reset, "]")
  stdout.flushFile

  stdout.write("\n\n\n", white, " 17). ", cyan, "search", reset, "[:", green, "path", reset, "]   ", cyan, "match", ":", green, "entry   ", reset)
  stdout.write(cyan, "limit", reset, ":", green, "number", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 18). ", cyan, "search", reset, "[:", green, "path", "]   ", reset, cyan, "match", ":", green, "entry   ", reset)
  stdout.write(cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 19). ", cyan, "search", reset, "[:", green, "path", reset, "]   ", cyan, "match", reset, ":", green, "entry   ", reset)
  stdout.write(cyan, "mode", reset, ":[", green, "passive", reset, "|", green, "strict", reset, "]   ")
  stdout.write(cyan, "limit", reset, ":", green, "number", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 20). ", cyan, "search", reset, "[:", green, "path", reset, "]   ", cyan, "match", reset, ":", green, "entry   ", reset)
  stdout.write(cyan, "mode", reset, ":[", green, "passive", reset, "|", green, "strict", reset, "]   ")
  stdout.write(cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 21). ", cyan, "search", reset, "[:", green, "path", reset, "]   ", cyan, "match", reset, ":", green, "entry   ", reset)
  stdout.write(cyan, "limit", reset, ":", green, "number   ", reset, cyan, "write", reset, ":", green, "file", reset)
  stdout.flushFile

  stdout.write("\n\n\n", white, " 22). ", cyan, "search", reset, "[:", green, "path", reset, "]   ", cyan, "match", reset, ":", green, "entry   ", reset)
  stdout.write(cyan, "mode", reset, ":[", green, "passive", reset, "|", green, "strict", reset, "]   ", cyan, "limit", reset, ":", green, "number   ", reset)
  stdout.write(cyan, "write", reset, ":", green, "file", reset, "\n")
  stdout.flushFile

  quit(0)
