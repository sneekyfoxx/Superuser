import std/[strutils, strformat, re]

proc sigintHandler() {.noconv.} =
  stdout.writeLine("\u001b[2K")
  stdout.flushFile
  quit(0)

const
  # 225, 205, 185, 165, 145, 125
  bolded: string = "\e[1m"
  dimmed: string = "\e[2m"
  italic: string = "\e[3m"

  underline: string = "\e[4m"
  codeblock: string = "\e[1;38;2;255;255;255;48;2;50;50;50m"
  strikeout: string = "\e[9m"

  h1: string = "\e[38;2;225;225;225m"
  h2: string = "\e[38;2;205;205;205m"
  h3: string = "\e[38;2;185;185;185m"
  h4: string = "\e[38;2;165;165;165m"
  h5: string = "\e[38;2;145;145;145m"
  h6: string = "\e[38;2;125;125;125m"

  normaltext: string = "\e[38;2;255;255;255m"
  othertext: string = "\e[38;2;30;255;255m"
  identifier: string = "\e[38;2;20;255;30m"

  reset: string = "\e[0m"

proc Parse(text: string): string =
  discard

proc Markdown*(file: string): string =
  # parse markdown text into ASNI equivalent
  var
    fileobj: File = open(file, fmRead)
    regex: Regex
    markdown: string = ""
    splitted: seq[string] = @[]
    pattern: seq[string] = @[]
  
  while (var line: string = try: fileobj.readLine() except EOFError: ""; line) != "":
    if line.startsWith("###### "):
      splitted = line.split("######", maxsplit=1)
      markdown &= "{dimmed}{identifier}######{reset}{bolded}{h6}{splitted[1]}{reset}\n".fmt

    elif line.startsWith("##### "):
      splitted = line.split("#####", maxsplit=1)
      markdown &= "{dimmed}{identifier}#####{reset}{bolded}{h5}{splitted[1]}{reset}\n".fmt

    elif line.startsWith("#### "):
      splitted = line.split("####", maxsplit=1)
      markdown &= "{dimmed}{identifier}####{reset}{bolded}{h4}{splitted[1]}{reset}\n".fmt

    elif line.startsWith("### "):
      splitted = line.split("###", maxsplit=1)
      markdown &= "{dimmed}{identifier}###{reset}{bolded}{h3}{splitted[1]}{reset}\n".fmt

    elif line.startsWith("## "):
      splitted = line.split("##", maxsplit=1)
      markdown &= "{dimmed}{identifier}##{reset}{bolded}{h2}{splitted[1]}{reset}\n".fmt

    elif line.startsWith("# "):
      splitted = line.split("#", maxsplit=1)
      markdown &= "{dimmed}{identifier}#{reset}{bolded}{h1}{splitted[1]}{reset}\n".fmt

    elif line.startsWith("- "):
      splitted = line.split("-", maxsplit=1)
      markdown &= "{dimmed}{identifier}-{reset}{othertext}{splitted[1]}{reset}\n".fmt

    elif (regex = re(r"\*{3}*\*{3}"); regex) != @[]:
      splitted = line.split("***", maxsplit=2)
      markdown &= "{dimmed}{identifier}***{reset}{bolded}{italic}{othertext}{splitted[1]}{reset}\n".fmt

    elif line.startsWith("**") and line.endsWith("**"):
      splitted = line.split("**", maxsplit=2)
      markdown &= "{dimmed}{identifier}**{reset}{bolded}{othertext}{splitted[1]}{reset}\n".fmt

    elif line.startsWith("*") and line.endsWith("*"):
      splitted = line.split("*", maxsplit=2)
      markdown &= "{dimmed}{identifier}*{reset}{italic}{othertext}{splitted[1]}{reset}\n".fmt

    elif line[0].isAlphaAscii() or line[0].isDigit() or line[0].isSpaceAscii():
      let expr: Regex = re(r"^\d+\. ")
      pattern = re.findAll(line, expr)
      
      if pattern.len == 1:
        splitted = line.split(pattern[0].strip(), maxsplit=1)
        markdown &= "{identifier}{splitted[0]}{reset}{othertext}{splitted[1]}{reset}\n".fmt

      else:
        markdown &= "{normaltext}{line}{reset}\n".fmt

    else:
      continue

  return markdown


setControlCHook(sigintHandler)
