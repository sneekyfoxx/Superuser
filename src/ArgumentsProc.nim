import strutils, strformat, terminal
import ActionsProc, EchoProc, ListProc, CountProc, InfoProc, SearchProc, JoinProc, OpenProc, UsageProc

proc sigintHandler() {.noconv.} =
  showCursor()
  stdout.flushFile
  quit(0)

const
  red: string = "\e[1;31m"
  yellow: string = "\e[33m"
  reset: string = "\e[0m"

proc arguments*(args: seq[string]) {.noreturn.} =
  var
    splitted: seq[string] = @[]
    splitted2: seq[string] = @[]
    splitted3: seq[string] = @[]
    splitted4: seq[string] = @[]
    splitted5: seq[string] = @[]
    files: seq[string] = @[]
    limit: int = 0

  if args.len == 0:
    quit(0)

  elif args.len == 1:
    if args[0] == "actions":
      ActionsProc.actions()

    elif args[0] == "usage":
      UsageProc.usage()

    elif args[0].startsWith("echo:"):
      splitted = args[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        EchoProc.echo(text = splitted[1])

    elif args[0] == "list" or args[0].startsWith("list:"):
      let colons: int = args[0].count(":")

      if colons == 0:
        ListProc.list()

      elif colons == 1:
        splitted = args[0].split(":")

        if splitted.len < 2 or splitted.len > 2:
          ActionsProc.actions()

        else:
          ListProc.list(directory = splitted[1])

      else:
        ActionsProc.actions()

    elif args[0] == "count":
      CountProc.count()

    elif args[0].startsWith("count:"):
      splitted = args[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        CountProc.count(directory = splitted[1])

    elif args[0].startsWith("info:"):
      splitted = args[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        InfoProc.info(splitted[1])

    elif args[0].startsWith("join:"):
      splitted = args[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        if splitted[1].count(",") < 1:
          ActionsProc.actions()

        else:
          files = splitted[1].split(",")
          JoinProc.join(files = files)

    elif args[0].startsWith("read:"):
      splitted = args[0].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        OpenProc.open(read = splitted[1])

    else:
      ActionsProc.actions()

  elif args.len == 2:
    if args[0].startsWith("echo:") and args[1].startsWith("write:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        EchoProc.echo(text = splitted[1], write = splitted2[1])

    elif args[0] == "list" and args[1].startsWith("match:"):
      splitted = args[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        ListProc.list(match = splitted[1])

    elif args[0] == "list" and args[1].startsWith("yield:"):
      var yieldCount: int = 0
      splitted = args[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        yieldCount = (try: parseInt(splitted[1]) * 1000 except ValueError: 0)
        
        if yieldCount != 0:
          ListProc.list(rate = yieldCount)

        else:
          yieldCount = (try: int(parseFloat(splitted[1]) * 1000) except ValueError: 0)

          if yieldCount != 0:
            ListProc.list(rate = yieldCount)

          else:
            ActionsProc.actions()

    elif args[0].startsWith("list:") and args[1].startsWith("match:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        ListProc.list(directory = splitted[1], match = splitted2[1])

    elif args[0].startsWith("list:") and args[1].startsWith("yield:"):
      var yieldCount = 0
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")

      if splitted.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        yieldCount = (try: parseInt(splitted2[1]) * 1000 except ValueError: 0)

        if yieldCount != 0:
          ListProc.list(directory = splitted[1], rate = yieldCount)

        else:
          yieldCount = (try: int(parseFloat(splitted2[1]) * 1000) except ValueError: 0)

          if yieldCount != 0:
            ListProc.list(directory = splitted[1], rate = yieldCount)

          else:
            ActionsProc.actions()

    elif args[0] == "search" and args[1].startsWith("match:"):
      splitted = args[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      else:
        SearchProc.search(name = splitted[1])

    elif args[0].startsWith("search:") and args[1].startsWith("match:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        SearchProc.search(path = splitted[1], name = splitted2[1])

    elif args[0].startsWith("join:") and args[1].startsWith("write:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")

      if splitted.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted[1].count(",") == 0:
        ActionsProc.actions()

      else:
        JoinProc.join(files = splitted[1].split(","), outfile = splitted2[1])

    elif args[0].startsWith("open:") and args[1].startsWith("append:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        OpenProc.open(open = splitted[1], append = splitted2[1])

    elif args[0].startsWith("open:") and args[1].startsWith("write:"):
      splitted = args[0].split(":")
      splitted = args[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
         ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()
      
      else:
        OpenProc.open(open = splitted[1], outfile = splitted2[1])

    elif args[0].startsWith("read:") and args[1].startsWith("write:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        OpenProc.open(read = splitted[1], outfile = splitted2[1])

    else:
      ActionsProc.actions()

  elif args.len == 3:
    if args[0] == "search" and args[1].startsWith("match:") and args[2].startsWith("limit:"):
      splitted = args[1].split(":")
      splitted2 = args[2].split(":")

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
            SearchProc.search(name = splitted[1], limit = limit)

        except ValueError:
          ActionsProc.actions()

    elif args[0] == "search" and args[1].startsWith("match:") and args[2].startsWith("mode:"):
      splitted = args[1].split(":")
      splitted2 = args[2].split(":")


      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted2[1] != "passive" and splitted2[1] != "strict":
        ActionsProc.actions()

      else:
        SearchProc.search(name = splitted[1], mode = splitted2[1])

    elif args[0] == "search" and args[1].startsWith("match:") and args[2].startsWith("write:"):
      splitted = args[1].split(":")
      splitted2 = args[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      else:
        SearchProc.search(name = splitted[1], outfile = splitted2[1])


    elif args[0].startsWith("search:") and args[1].startsWith("match:") and args[2].startsWith("limit:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")
      splitted3 = args[2].split(":")

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
            SearchProc.search(path = splitted[1], name = splitted2[1], limit = limit)

        except ValueError:
          ActionsProc.actions()

    elif args[0].startsWith("search:") and args[1].startsWith("match:") and args[2].startsWith("mode:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")
      splitted3 = args[2].split(":")


      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted3[1] != "passive" and splitted3[1] != "strict":
        ActionsProc.actions()

      else:
        SearchProc.search(path = splitted[1], name = splitted2[1], mode = splitted3[1])

    elif args[0].startsWith("search:") and args[1].startsWith("match:") and args[2].startsWith("write:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")
      splitted3 = args[2].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      else:
        SearchProc.search(path = splitted[1], name = splitted2[1], outfile = splitted3[1])

    else:
      ActionsProc.actions()

  elif args.len == 4:
    if args[0] == "search" and args[1].startsWith("match:") and args[2].startsWith("mode:") and args[3].startsWith("limit:"):
      splitted = args[1].split(":")
      splitted2 = args[2].split(":")
      splitted3 = args[3].split(":")

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
          limit = parseInt(splitted3[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            SearchProc.search(name = splitted[1], mode = splitted2[1], limit = limit)

        except ValueError:
          ActionsProc.actions()

    elif args[0] == "search" and args[1].startsWith("match:") and args[2].startsWith("mode:") and args[3].startsWith("write:"):
      splitted = args[1].split(":")
      splitted2 = args[2].split(":")
      splitted3 = args[3].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted2[1] != "passive" and splitted2[1] != "strict":
        ActionsProc.actions()

      else:
        SearchProc.search(name = splitted[1], mode = splitted2[1], outfile = splitted3[1])

    elif args[0] == "search" and args[1].startsWith("match:") and args[2].startsWith("limit:") and args[3].startsWith("write:"):
      splitted = args[1].split(":")
      splitted2 = args[2].split(":")
      splitted3 = args[3].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      else:
        try:
          limit = parseInt(splitted2[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            SearchProc.search(name = splitted[1], limit = limit, outfile = splitted3[1])

        except ValueError:
          ActionsProc.actions()

    if args[0].startsWith("search:") and args[1].startsWith("match:") and args[2].startsWith("mode:") and args[3].startsWith("limit:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")
      splitted3 = args[2].split(":")
      splitted4 = args[3].split(":")

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
            SearchProc.search(path = splitted[1], name = splitted2[1], mode = splitted3[1], limit = limit)

        except ValueError:
          ActionsProc.actions()

    elif args[0].startsWith("search:") and args[1].startsWith("match:") and args[2].startsWith("mode:") and args[3].startsWith("write:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")
      splitted3 = args[2].split(":")
      splitted4 = args[3].split(":")

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
        SearchProc.search(path = splitted[1], name = splitted2[1], mode = splitted3[1], outfile = splitted4[1])

    elif args[0].startsWith("search:") and args[1].startsWith("match:") and args[2].startsWith("limit:") and args[3].startsWith("write:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")
      splitted3 = args[2].split(":")
      splitted4 = args[3].split(":")

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
            SearchProc.search(path = splitted[1], name = splitted2[1], limit = limit, outfile = splitted4[1])

        except ValueError:
          ActionsProc.actions()

  elif args.len == 5:
    if args[0] == "search" and args[1].startsWith("match:") and args[2].startsWith("mode:") and args[3].startsWith("limit:") and args[4].startsWith("write:"):
      splitted = args[1].split(":")
      splitted2 = args[2].split(":")
      splitted3 = args[3].split(":")
      splitted4 = args[4].split(":")

      if splitted.len < 2 or splitted.len > 2:
        ActionsProc.actions()

      elif splitted2.len < 2 or splitted2.len > 2:
        ActionsProc.actions()

      elif splitted3.len < 2 or splitted3.len > 2:
        ActionsProc.actions()

      elif splitted4.len < 2 or splitted4.len > 2:
        ActionsProc.actions()

      elif splitted2[1] != "passive" and splitted2[1] != "strict":
        ActionsProc.actions()

      else:
        try:
          limit = parseInt(splitted3[1])

          if limit < 0:
            stderr.writeLine("\n", red, "ERROR", reset, ": ", yellow, "the limit must be a positive number\n", reset)
            stderr.flushFile
            quit(1)

          else:
            SearchProc.search(name = splitted[1], mode = splitted2[1], limit = limit, outfile = splitted4[1])

        except ValueError:
          ActionsProc.actions()


    if args[0].startsWith("search:") and args[1].startsWith("match:") and args[2].startsWith("mode:") and args[3].startsWith("limit:") and args[4].startsWith("write:"):
      splitted = args[0].split(":")
      splitted2 = args[1].split(":")
      splitted3 = args[2].split(":")
      splitted4 = args[3].split(":")
      splitted5 = args[4].split(":")

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
            SearchProc.search(path = splitted[1], name = splitted2[1], mode = splitted3[1], limit = limit, outfile = splitted5[1])

        except ValueError:
          ActionsProc.actions()

  else:
    stderr.write("\n{red}ERROR:{reset} {yellow}too many args{reset}".fmt)
    stderr.flushFile
    quit(1)

setControlCHook(sigintHandler)
