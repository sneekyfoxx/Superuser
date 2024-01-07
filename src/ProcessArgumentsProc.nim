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

proc ProcessArguments*(arguments: seq[string]) {.noReturn.} =
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
      ActionsProc.Actions()

    elif arguments[0] == "usage":
      UsageProc.Usage()

    elif arguments[0].startsWith("echo:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      else:
        EchoProc.Echo(text = splitted[1])

    elif arguments[0] == "entries"or arguments[0].startsWith("entries:"):
      let colons: int = arguments[0].count(":")

      if colons == 0:
        EntriesProc.Entries()

      elif colons == 1:
        splitted = arguments[0].split(":")

        if splitted.len < 2 or splitted.len > 2:
          ActionsProc.Actions()

        else:
          EntriesProc.Entries(directory = splitted[1])

      else:
        ActionsProc.Actions()

    elif arguments[0] == "entrycount":
      EntryCountProc.EntryCount()

    elif arguments[0].startsWith("entrycount:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      else:
        EntryCountProc.EntryCount(directory = splitted[1])

    elif arguments[0].startsWith("entryinfo:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      else:
        EntryInfoProc.EntryInfo(splitted[1])

    elif arguments[0].startsWith("find:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      else:
        FindProc.Find(name = splitted[1])

    elif arguments[0].startsWith("join:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      else:
        if splitted[1].count(",") < 1:
          ActionsProc.Actions()

        else:
          files = splitted[1].split(",")
          JoinProc.Join(files = files)

    elif arguments[0].startsWith("read:"):
      splitted = arguments[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      else:
        OpenProc.Open(Read = splitted[1])

    else:
      ActionsProc.Actions()

  elif arguments.len == 2:
    if arguments[0].startsWith("echo:") and arguments[1].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      else:
        EchoProc.Echo(text = splitted[1], Write = splitted2[1])

    elif arguments[0].startsWith("entries") and arguments[1].startsWith("match:"):
      colons = arguments[0].count(":")
      splitted2 = arguments[1].split(":")

      if splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      else:
        if colons == 0:
          EntriesProc.Entries(match = splitted2[1])
        
        elif colons == 1:
          splitted = arguments[0].split(":")

          if splitted.len < 2 or splitted.len > 2:
            ActionsProc.Actions()

          else:
            EntriesProc.Entries(directory = splitted[1], match = splitted2[1])

        else:
          ActionsProc.Actions()

    elif arguments[0] == "entries" and arguments[1].startsWith("yield:"):
      var yieldCount: int = 0
      splitted2 = arguments[1].split(":")

      if splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      else:
        yieldCount = (try: parseInt(splitted2[1]) * 1000 except ValueError: 0)
        
        if yieldCount != 0:
          EntriesProc.Entries(Yield = yieldCount)

        else:
          yieldCount = (try: int(parseFloat(splitted2[1]) * 1000) except ValueError: 0)

          if yieldCount != 0:
            EntriesProc.Entries(Yield = yieldCount)

          else:
            ActionsProc.Actions()

    elif arguments[0].startsWith("entries:") and arguments[1].startsWith("yield:"):
      var yieldCount = 0
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      else:
        yieldCount = (try: parseInt(splitted2[1]) * 1000 except ValueError: 0)

        if yieldCount != 0:
          EntriesProc.Entries(directory = splitted[1], Yield = yieldCount)

        else:
          yieldCount = (try: int(parseFloat(splitted2[1]) * 1000) except ValueError: 0)

          if yieldCount != 0:
            EntriesProc.Entries(directory = splitted[1], Yield = yieldCount)

          else:
            ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      else:
        FindProc.Find(name = splitted[1], use = splitted2[1])

    if arguments[0].startsWith("find:") and arguments[1].startsWith("mode:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted2[1] != "passive" and splitted2[1] != "strict":
        ActionsProc.Actions()

      else:
        FindProc.Find(name = splitted[1], mode = splitted2[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("limit:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      else:
        try:
          limit = parseInt(splitted2[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = splitted[1], limit = limit)

        except ValueError:
          ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      else:
        FindProc.Find(name = splitted[1], Write = splitted2[1])

    elif arguments[0].startsWith("join:") and arguments[1].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted[1].count(",") == 0:
        ActionsProc.Actions()

      else:
        JoinProc.Join(files = splitted[1].split(","), Write = splitted2[1])

    elif arguments[0].startsWith("open:") and arguments[1].startsWith("append:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      else:
        OpenProc.Open(Open = splitted[1], Append = splitted2[1])

    elif arguments[0].startsWith("open:") and arguments[1].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
         ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()
      
      else:
        OpenProc.Open(Open = splitted[1], Write = splitted2[1])

    elif arguments[0].startsWith("read:") and arguments[1].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      else:
        OpenProc.Open(Read = splitted[1], Write = splitted2[1])

    else:
      ActionsProc.Actions()

  elif arguments.len == 3:
    if arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("limit:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.Actions()

      else:
        try:
          limit = parseInt(splitted3[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = splitted[1], use = splitted2[1], limit = limit)

        except ValueError:
          ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")


      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.Actions()

      elif splitted3[1] != "passive" and splitted3[1] != "strict":
        ActionsProc.Actions()

      else:
        FindProc.Find(name = splitted[1], use = splitted2[1], mode = splitted3[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("mode:") and arguments[2].startsWith("limit:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.Actions()

      elif splitted2[1] != "passive" and splitted2[1] != "strict":
        ActionsProc.Actions()

      else:
        try:
          limit = parseInt(splitted2[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = splitted[1], mode = splitted2[1], limit = limit)

        except ValueError:
          ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.Actions()

      else:
        FindProc.Find(name = splitted[1], use = splitted2[1], Write = splitted3[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("mode:") and arguments[2].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.Actions()

      elif splitted2[1] != "passive" and splitted2[1] != "strict":
        ActionsProc.Actions()

      else:
        FindProc.Find(name = splitted[1], mode = splitted2[1], Write = splitted3[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("limit:") and arguments[2].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      else:
        try:
          limit = parseInt(splitted2[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = splitted[1], limit = limit, Write = splitted3[1])

        except ValueError:
          ActionsProc.Actions()

    else:
      ActionsProc.Actions()

  elif arguments.len == 4:
    if arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:") and arguments[3].startsWith("limit:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")
      splitted4 = arguments[3].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.Actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.Actions()

      elif splitted3[1] != "passive" and splitted3[1] != "strict":
        ActionsProc.Actions()

      else:
        try:
          limit = parseInt(splitted4[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = splitted[1], use = splitted2[1], mode = splitted3[1], limit = limit)

        except ValueError:
          ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:") and arguments[3].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")
      splitted4 = arguments[3].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.Actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.Actions()

      elif splitted3[1] != "passive" and splitted3[1] != "strict":
        ActionsProc.Actions()

      else:
        FindProc.Find(name = splitted[1], use = splitted2[1], mode = splitted3[1], Write = splitted4[1])

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("limit:") and arguments[3].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")
      splitted4 = arguments[3].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.Actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.Actions()

      else:
        try:
          limit = parseInt(splitted3[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = splitted[1], use = splitted2[1], limit = limit, Write = splitted4[1])

        except ValueError:
          ActionsProc.Actions()

    elif arguments[0].startsWith("find:") and arguments[1].startsWith("mode:") and arguments[2].startsWith("limit:") and arguments[3].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")
      splitted4 = arguments[3].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.Actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.Actions()

      else:
        try:
          limit = parseInt(splitted3[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = splitted[1], mode = splitted2[1], limit = limit, Write = splitted4[1])

        except ValueError:
          ActionsProc.Actions()

  elif arguments.len == 5:
    if arguments[0].startsWith("find:") and arguments[1].startsWith("use:") and arguments[2].startsWith("mode:") and arguments[3].startsWith("limit:") and arguments[4].startsWith("write:"):
      splitted = arguments[0].split(":")
      splitted2 = arguments[1].split(":")
      splitted3 = arguments[2].split(":")
      splitted4 = arguments[3].split(":")
      splitted5 = arguments[4].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.Actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.Actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.Actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.Actions()

      elif splitted5.len < 2 or splitted5.len > 2:
        ActionsProc.Actions()

      elif splitted3[1] != "passive" and splitted3[1] != "strict":
        ActionsProc.Actions()

      else:
        try:
          limit = parseInt(splitted4[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            FindProc.Find(name = splitted[1], use = splitted2[1], mode = splitted[1], limit = limit, Write = splitted5[1])

        except ValueError:
          ActionsProc.Actions()

  else:
    stderr.write("\n{red}ERROR:{reset} {yellow}too many arguments{reset}".fmt)
    stderr.flushFile
    quit(1)

setControlCHook(sigintHandler)
