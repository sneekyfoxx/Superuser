import std/[strutils, strformat, terminal]
import ActionsProc, EchoProc, EntriesProc, EntryCountProc, EntryInfoProc, FindProc, JoinProc, OpenProc, UsageProc

# Start @ Line: 208

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
  stdout.flushFile
  quit(0)

const
  red: string = "\e[1;31m"
  yellow: string = "\e[33m"
  reset: string = "\e[0m"

if not isatty(stdin) or not isatty(stdout):
  stderr.writeLine("\n{red}ERROR: {reset}{yellow}pipes aren't supported{reset}\n".fmt)
  stderr.flushFile
  quit(1)

proc processArguments*(arguments: seq[string]) {.noreturn.} =
  var
    splitted: seq[string] = @[]
    splitted2: seq[string] = @[]
    splitted3: seq[string] = @[]
    splitted4: seq[string] = @[]
    splitted5: seq[string] = @[]
    files: seq[string] = @[]
    limit: int = 0
    colons: int = 0 

  if arguments.len == 0:
    quit(0)

  elif arguments.len == 1:
    if arguments[0] == "actions":
      ActionsProc.actions()

    elif arguments[0] == "usage":
      UsageProc.usage()

    elif arguments[0].startsWith("echo:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        EchoProc.echo(text = splitted[1])

    elif arguments[0] == "entries" or arguments[0].startsWith("entries:"):
      let colons: int = arguments[0].count(":")

      if colons == 0:
        EntriesProc.entries()

      elif colons == 1:
        splitted = arguments[0].split(":")

        if splitted.len < 2 or splitted.len > 2:
          ActionsProc.actions()

        else:
          EntriesProc.entries(directory = splitted[1])

      else:
        ActionsProc.actions()

    elif arguments[0] == "entrycount":
      EntryCountProc.entryCount()

    elif arguments[0].startsWith("entrycount:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        EntryCountProc.entryCount(directory = splitted[1])

    elif arguments[0].startsWith("entryinfo:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        EntryInfoProc.entryInfo(splitted[1])

    elif arguments[0].startsWith("find:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        FindProc.find(name = splitted[1])

    elif arguments[0].startsWith("join:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        if splitted[1].count(",") < 1:
          ActionsProc.actions()

        else:
          files = splitted[1].split(",")
          JoinProc.join(files = files)

    elif arguments[0].startsWith("read:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        OpenProc.open(read = splitted[1])

    else:
      ActionsProc.actions()

  elif arguments.len == 2:
    if arguments[0].startsWith("echo:") and arguments[1].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        EchoProc.echo(text = splitted[1], write = splitted2[1])

    elif arguments[0].startsWith("entries") and arguments[1].startsWith("match:"):
      colons = arguments[0].count(":")
      splitted2 = arguments[1].split(":")

      if splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        if colons == 0:
          EntriesProc.entries(match = splitted2[1])
        
        elif colons == 1:
          splitted = arguments[0].split(":")

          if splitted.len < 2 or splitted.len > 2:
            ActionsProc.actions()

          else:
            EntriesProc.entries(directory = splitted[1], match = splitted2[1])

        else:
          ActionsProc.actions()

    elif arguments[0] == "entries" and arguments[1].startsWith("yield:"):
      var yieldCount: int = 0
      splitted2 = arguments[1].split(":")

      if splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        yieldCount = (try: parseInt(splitted2[1]) * 1000 except ValueError: 0)
        
        if yieldCount != 0:
          EntriesProc.entries(rate = yieldCount)

        else:
          yieldCount = (try: int(parseFloat(splitted2[1]) * 1000) except ValueError: 0)

          if yieldCount != 0:
            EntriesProc.entries(rate = yieldCount)

          else:
            ActionsProc.actions()

    elif arguments[0].startsWith("entries:") and arguments[1].startsWith("yield:"):
      var yieldCount = 0
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        yieldCount = (try: parseInt(splitted2[1]) * 1000 except ValueError: 0)

        if yieldCount != 0:
          EntriesProc.entries(directory = splitted[1], rate = yieldCount)

        else:
          yieldCount = (try: int(parseFloat(splitted2[1]) * 1000) except ValueError: 0)

          if yieldCount != 0:
            EntriesProc.entries(directory = splitted[1], rate = yieldCount)

          else:
            ActionsProc.actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        FindProc.find(name = splitted[1], use = splitted2[1])

    if arguments[0].startsWith("find:") and arguments[1].startsWith("mode:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted2[1] != "passive" and splitted2[1] != "strict":
        ActionsProc.actions()

      else:
        FindProc.find(name = splitted[1], mode = splitted2[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("limit:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        try:
          limit = parseInt(splitted2[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.find(name = splitted[1], limit = limit)

        except ValueError:
          ActionsProc.actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        FindProc.find(name = splitted[1], outfile = splitted2[1])

    elif arguments[0].startsWith("join:") and arguments[1].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted[1].count(",") == 0:
        ActionsProc.actions()

      else:
        JoinProc.join(files = splitted[1].split(","), outfile = splitted2[1])

    elif arguments[0].startsWith("open:") and arguments[1].startsWith("append:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        OpenProc.open(open = splitted[1], append = splitted2[1])

    elif arguments[0].startsWith("open:") and arguments[1].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
         ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()
      
      else:
        OpenProc.open(open = splitted[1], outfile = splitted2[1])

    elif arguments[0].startsWith("read:") and arguments[1].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        OpenProc.open(read = splitted[1], outfile = splitted2[1])

    else:
      ActionsProc.actions()

  elif arguments.len == 3:
    if arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("limit:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      else:
        try:
          limit = parseInt(splitted3[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.find(name = splitted[1], use = splitted2[1], limit = limit)

        except ValueError:
          ActionsProc.actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")


      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted3[1] != "passive" and splitted3[1] != "strict":
        ActionsProc.actions()

      else:
        FindProc.find(name = splitted[1], use = splitted2[1], mode = splitted3[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("mode:") and arguments[2].startsWith("limit:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted2[1] != "passive" and splitted2[1] != "strict":
        ActionsProc.actions()

      else:
        try:
          limit = parseInt(splitted2[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.find(name = splitted[1], mode = splitted2[1], limit = limit)

        except ValueError:
          ActionsProc.actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      else:
        FindProc.find(name = splitted[1], use = splitted2[1], outfile = splitted3[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("mode:") and arguments[2].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted2[1] != "passive" and splitted2[1] != "strict":
        ActionsProc.actions()

      else:
        FindProc.find(name = splitted[1], mode = splitted2[1], outfile = splitted3[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("limit:") and arguments[2].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        try:
          limit = parseInt(splitted2[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.find(name = splitted[1], limit = limit, outfile = splitted3[1])

        except ValueError:
          ActionsProc.actions()

    else:
      ActionsProc.actions()

  elif arguments.len == 4:
    if arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:") and arguments[3].startsWith("limit:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")
      splitted4 = arguments[3].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.actions()

      elif splitted3[1] != "passive" and splitted3[1] != "strict":
        ActionsProc.actions()

      else:
        try:
          limit = parseInt(splitted4[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.find(name = splitted[1], use = splitted2[1], mode = splitted3[1], limit = limit)

        except ValueError:
          ActionsProc.actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:") and arguments[3].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")
      splitted4 = arguments[3].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.actions()

      elif splitted3[1] != "passive" and splitted3[1] != "strict":
        ActionsProc.actions()

      else:
        FindProc.find(name = splitted[1], use = splitted2[1], mode = splitted3[1], outfile = splitted4[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("limit:") and arguments[3].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")
      splitted4 = arguments[3].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.actions()

      else:
        try:
          limit = parseInt(splitted3[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.find(name = splitted[1], use = splitted2[1], limit = limit, outfile = splitted4[1])

        except ValueError:
          ActionsProc.actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("mode:") and arguments[2].startsWith("limit:") and arguments[3].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")
      splitted4 = arguments[3].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.actions()

      else:
        try:
          limit = parseInt(splitted3[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.find(name = splitted[1], mode = splitted2[1], limit = limit, outfile = splitted4[1])

        except ValueError:
          ActionsProc.actions()

  elif arguments.len == 5:
    if arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:") and arguments[3].startsWith("limit:") and arguments[4].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")
      splitted4 = arguments[3].split(":")
      splitted5 = arguments[4].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.actions()

      elif splitted5.len < 2 or splitted5.len > 2:
        ActionsProc.actions()

      elif splitted3[1] != "passive" and splitted3[1] != "strict":
        ActionsProc.actions()

      else:
        try:
          limit = parseInt(splitted4[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.find(name = splitted[1], use = splitted2[1], mode = splitted3[1], limit = limit, outfile = splitted5[1])

        except ValueError:
          ActionsProc.actions()

  else:
    stderr.write("\n{red}ERROR:{reset} {yellow}too many arguments{reset}".fmt)
    stderr.flushFile
    quit(1)

setControlCHook(sigintHandler)
