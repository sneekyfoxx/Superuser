import std/[strutils, strformat, terminal]
import ActionsProc, EchoProc, EntriesProc, EntryCountProc, EntryInfoProc, FindProc, JoinProc, OpenProc, UsageProc

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
  stdout.flushFile
  quit(0)

const
  red: string = "\e[1;31m"
  yellow: string = "\e[33m"
  blue: string = "\e[1;34m"
  reset: string = "\e[0m"

if not isatty(stdin) or not isatty(stdout):
  stderr.writeLine("\n{red}ERROR: {reset}{yellow}pipes aren't supported{reset}\n".fmt)
  stderr.flushFile
  quit(1)

proc ProcessArguments*(arguments: seq[string]) {.noReturn.} =
  if arguments.len == 0:
    quit(0)

  elif arguments.len == 1:
    if arguments[0] == "actions":
      ActionsProc.Actions()

    elif arguments[0] == "usage":
      UsageProc.Usage()

    elif arguments[0].startsWith("echo:"):
      if arguments[0].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        EchoProc.Echo(text = arguments[0].split(":")[1])

    elif arguments[0].startsWith("entries"):
      if arguments[0].count(":") > 1:
        ActionsProc.Actions()

      elif arguments[0].count(":") == 0:
        EntriesProc.Entries()

      elif arguments[0].count(":") == 1 and arguments[0].split(":")[1].len == 0:
        stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "an argument must be provided after the ", reset, "'", blue, ":", reset, "'\n")
        stderr.flushFile
        quit(1)

      else:
        EntriesProc.Entries(directory = arguments[0].split(":")[1])

    elif arguments[0] == "entrycount":
      EntryCountProc.EntryCount()

    elif arguments[0].startsWith("entrycount:"):
      if arguments[0].split(":")[1].len == 0:
        stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "an argument must be provided after the ", reset, "'", blue, ":", reset, "'\n")
        stderr.flushFile
        quit(1)

      else:
        EntryCountProc.EntryCount(directory = arguments[0].split(":")[1])

    elif arguments[0].startsWith("entryinfo:"):
      if arguments[0].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        EntryInfoProc.EntryInfo(arguments[0].split(":")[1])

    elif arguments[0].startsWith("find:"):
      if arguments[0].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        FindProc.Find(name = arguments[0].split(":")[1])

    elif arguments[0].startsWith("join:"):
      if arguments[0].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[0].split(":")[1].count(",") == 0:
        stderr.writeLine("\n{red}ERROR{reset}: two or more arguments must be supplied after the '{blue}:{reset}' and separated using a '{blue},{reset}'\n".fmt)
        stderr.flushFile
        quit(1)

      else:
        JoinProc.Join(files = arguments[0].split(":")[1].split(","))

    elif arguments[0].startsWith("read:"):
      if arguments[0].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        OpenProc.Open(Read = arguments[0].split(":")[1])

    else:
      ActionsProc.Actions()

  elif arguments.len == 2:
    if arguments[0].startsWith("echo:") and arguments[1].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        EchoProc.Echo(text = arguments[0].split(":")[1], Write = arguments[1].split(":")[1])

    elif arguments[0].startsWith("entries") and arguments[1].startsWith("match:"):
      if arguments[0].count(":") > 1 or arguments[1].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[0].count(":") == 0:
        EntriesProc.Entries(match = arguments[1].split(":")[1])

      elif arguments[0].count(":") == 1 and arguments[0].split(":")[1].len == 0:
        stderr.writeLine("\n{red}ERROR{reset}: {yellow}and argument must be provided after the '{blue}:{reset}'\n".fmt)
        stderr.flushFile
        quit(1)

      elif arguments[0].count(":") == 1:
        EntriesProc.Entries(directory = arguments[0].split(":")[1], match = arguments[1].split(":")[1])

      else:
        ActionsProc.Actions()

    elif arguments[0].startsWith("entries") and arguments[1].startsWith("yield:"):
      if arguments[0].count(":") > 1 or arguments[1].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[0].count(":") == 0:
        try:
          var yieldCount: int = parseInt(arguments[1].split(":")[1])
          EntriesProc.Entries(Yield = yieldCount)

        except ValueError:
          ActionsProc.Actions()

      elif arguments[0].count(":") == 1 and arguments[0].split(":")[1].len == 0:
        stderr.writeLine("\n{red}ERROR{reset}: {yellow}an argument must be provided after the '{blue}:{reset}'\n".fmt)
        stderr.flushFile
        quit(1)

      elif arguments[0].count(":") == 1:
        try:
          var yieldCount: int = parseInt(arguments[1].split(":")[1])
          EntriesProc.Entries(directory = arguments[0].split(":")[1], Yield = yieldCount)

        except ValueError:
          ActionsProc.Actions()

      else:
        ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        FindProc.Find(name = arguments[0].split(":")[1], use = arguments[1].split(":")[1])

    if arguments[0].startsWith("find:") and arguments[1].startsWith("mode:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[1].split(":")[1] != "passive" and arguments[1].split(":")[1] != "strict":
        ActionsProc.Actions()

      else:
        FindProc.Find(name = arguments[0].split(":")[1], mode = arguments[1].split(":")[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("limit:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        try:
          var limit: int = parseInt(arguments[1].split(":")[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = arguments[0].split(":")[1], limit = limit)

        except ValueError:
          ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        FindProc.Find(name = arguments[0].split(":")[1], Write = arguments[1].split(":")[1])

    elif arguments[0].startsWith("join:") and arguments[1].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[0].split(":")[1].count(",") == 0:
        stderr.writeLine("\n{red}ERROR{reset}: two or more arguments must be supplied after the '{blue}:{reset}' and separated using a '{blue},{reset}'\n".fmt)
        stderr.flushFile
        quit(1)

      else:
        JoinProc.Join(files = arguments[0].split(":")[1].split(","), Write = arguments[1].split(":")[1])

    elif arguments[0].startsWith("open:") and arguments[1].startsWith("append:"):
      if arguments[0].split(":")[1].len == 0 or arguments[0].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        OpenProc.Open(Open = arguments[0].split(":")[1], Append = arguments[1].split(":")[1])

    elif arguments[0].startsWith("open:") and arguments[1].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[0].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        OpenProc.Open(Open = arguments[0].split(":")[1], Write = arguments[1].split(":")[1])

    elif arguments[0].startsWith("read:") and arguments[1].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        OpenProc.Open(Read = arguments[0].split(":")[1], Write = arguments[1].split(":")[1])

    else:
      ActionsProc.Actions()

  elif arguments.len == 3:
    if arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("limit:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        try:
          var limit: int = parseInt(arguments[2].split(":")[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = arguments[0].split(":")[1], use = arguments[1].split(":")[1], limit = limit)

        except ValueError:
          ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[2].split(":")[1] != "passive" and arguments[2].split(":")[1] != "strict":
        ActionsProc.Actions()

      else:
        FindProc.Find(name = arguments[0].split(":")[1], use = arguments[1].split(":")[1], mode = arguments[2].split(":")[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("mode:") and arguments[2].startsWith("limit:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[1].split(":")[1] != "passive" and arguments[1].split(":")[1] != "strict":
        ActionsProc.Actions()

      else:
        try:
          var limit: int = parseInt(arguments[2].split(":")[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = arguments[0].split(":")[1], mode = arguments[1].split(":")[1], limit = limit)

        except ValueError:
          ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        FindProc.Find(name = arguments[0].split(":")[1], use = arguments[1].split(":")[1], Write = arguments[2].split(":")[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("mode:") and arguments[2].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[1].split(":")[1] != "passive" and arguments[1].split(":")[1] != "strict":
        ActionsProc.Actions()

      else:
        FindProc.Find(name = arguments[0].split(":")[1], mode = arguments[1].split(":")[1], Write = arguments[2].split(":")[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("limit:") and arguments[2].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        try:
          var limit: int = parseInt(arguments[1].split(":")[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = arguments[0].split(":")[1], limit = limit, Write = arguments[2].split(":")[1])

        except ValueError:
          ActionsProc.Actions()

    else:
      ActionsProc.Actions()

  elif arguments.len == 4:
    if arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:") and arguments[3].startsWith("limit:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0 or arguments[3].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[2].split(":")[1] != "passive" and arguments[2].split(":")[1] != "strict":
        ActionsProc.Actions()

      else:
        try:
          var limit: int = parseInt(arguments[3].split(":")[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = arguments[0].split(":")[1], use = arguments[1].split(":")[1], mode = arguments[2].split(":")[1], limit = limit)

        except ValueError:
          ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:") and arguments[3].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0 or arguments[3].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[2].split(":")[1] != "passive" and arguments[2].split(":")[1] != "strict":
        ActionsProc.Actions()

      else:
        FindProc.Find(name = arguments[0].split(":")[1], use = arguments[1].split(":")[1], mode = arguments[2].split(":")[1], Write = arguments[3].split(":")[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("limit:") and arguments[3].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0 or arguments[3].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        try:
          var limit: int = parseInt(arguments[2].split(":")[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = arguments[0].split(":")[1], use = arguments[1].split(":")[1], limit = limit, Write = arguments[3].split(":")[1])

        except ValueError:
          ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("mode:") and arguments[2].startsWith("limit:") and arguments[3].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0 or arguments[3].split(":")[1].len == 0:
        ActionsProc.Actions()

      else:
        try:
          var limit: int = parseInt(arguments[2].split(":")[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = arguments[0].split(":")[1], mode = arguments[1].split(":")[1], limit = limit, Write = arguments[3].split(":")[1])

        except ValueError:
          ActionsProc.Actions()

  elif arguments.len == 5:
    if arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:") and arguments[3].startsWith("limit:") and arguments[4].startsWith("write:"):
      if arguments[0].split(":")[1].len == 0 or arguments[1].split(":")[1].len == 0 or arguments[2].split(":")[1].len == 0 or arguments[3].split(":")[1].len == 0 or arguments[4].split(":")[1].len == 0:
        ActionsProc.Actions()

      elif arguments[2].split(":")[1] != "passive" and arguments[2].split(":")[1] != "strict":
        ActionsProc.Actions()

      else:
        try:
          var limit: int = parseInt(arguments[3].split(":")[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = arguments[0].split(":")[1], use = arguments[1].split(":")[1], mode = arguments[2].split(":")[1], limit = limit, Write = arguments[4].split(":")[1])

        except ValueError:
          ActionsProc.Actions()

  else:
    stderr.write("\n{red}ERROR:{reset} {yellow}too many arguments{reset}".fmt)
    stderr.flushFile
    quit(1)

setControlCHook(sigintHandler)
