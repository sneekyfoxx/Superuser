import std/strutils

proc replace*(text: string): string =
  return multiReplace(text, (r"\n", "\n"), (r"\t", "\t"), (r"\r", "\r"), (r"\f", "\f"), (r"\e", "\e"), (r"\x1b", "\e"), (r"\033", "\e"), (r"\u001b", "\e"), (r"\b", "\b"), (r"\a", "\a"), (r"\v", "\v"), (r"\0", ""))
