import std/strformat

const
  red: string = "\e[1;31m"
  green: string = "\e[1;32m"
  yellow: string = "\e[1;33m"
  blue: string = "\e[1;34m"
  magenta: string = "\e[1;35m"
  cyan: string = "\e[1;36m"
  reset: string = "\e[0m"


proc Actions* {.noReturn.} =
  stdout.writeLine(red, "\n―――――――――――――――――――――――――――――――――――――――――――", reset, "{", magenta, "superuser", reset, "}", red, "―――――――――――――――――――――――――――――――――――――――――――", reset)
  stdout.flushFile

  stdout.write("\n", blue, "Author", reset, ": ", magenta, "Rayshawn Levy", reset, "\n")
  stdout.flushFile

  stdout.writeLine("\n{blue}Description{reset}: {yellow}A useful command for any{reset} {magenta}superuser{reset}{yellow}.{reset}".fmt)
  stdout.flushFile

  stdout.write("\n{blue}NOTE{reset}: {yellow}{red}/{reset}{yellow}'s and {reset}{red}\\{reset}".fmt)
  stdout.write("{yellow}'s in any{reset} '{green}name{reset}' {yellow}given as an argument to{reset} {cyan}find:{reset}{yellow} is{reset} {red}invalid.{reset}\n".fmt)
  stdout.flushFile

  stdout.writeLine("\n\n{green}Action\t\t\t\tDescription{reset}\n‾‾‾‾‾‾\t\t\t\t‾‾‾‾‾‾‾‾‾‾‾".fmt)
  stdout.flushFile

  stdout.writeLine(" {cyan}actions{reset}\t\t\t {yellow}show info for all{reset} {magenta}superuser{reset} {yellow}actions{reset}".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}append{reset}:{green}text{reset}\t\t\t '{green}text{reset}' {yellow}is added to the end of{reset} '{cyan}open{reset}:{green}file{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}echo{reset}:{green}text{reset}\t\t\t '{green}text{reset}' {yellow}that is collected and sent to{reset} '{magenta}stdout{reset}' {yellow}or to{reset} '{cyan}write{reset}:{green}file{reset}'".fmt)

  stdout.writeLine("\n {cyan}entries{reset}[:{green}directory{reset}]\t\t {yellow}list the entries in the specified{reset} '{green}directory{reset}'. {yellow}The default is{reset} '{green}./{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}entrycount{reset}[:{green}directory{reset}]\t\t {yellow}recursively count all entries in {reset}'{green}directory{reset}'. {yellow}The default is{reset} '{green}./{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}entryinfo{reset}:{green}entry{reset}\t\t {yellow}get information on a {reset}{blue}File{reset} {yellow}or{reset} {blue}Directory{reset} '{green}entry{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}find{reset}:{green}name{reset}\t\t\t {yellow}search the filesystem for the given{reset} '{green}name{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}join{reset}:{green}file1{reset},{green}file2{reset}[,{green}...{reset}]\t\t {yellow}join the contents of multiple files into{reset} '{green}file1{reset}' {yellow}or{reset} '{cyan}write{reset}:{green}file{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}limit{reset}:{green}number{reset}\t\t\t {yellow}limit the number of finds to{reset} '{green}number{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}match{reset}:{green}name{reset}\t\t\t {yellow}match an entry{reset} '{green}name{reset}' {yellow}when listing directory entries{reset}".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}mode{reset}:[{green}passive{reset}|{green}strict{reset}]\t\t {yellow}set the search state to{reset} '{green}passive{reset}' {yellow}or{reset} '{green}strict{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n     :{green}passive{reset}\t\t\t {yellow}find all paths containing{reset} '{green}name{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n     :{green}strict{reset}\t\t\t {yellow}find all paths ending in{reset} '{green}name{reset}'. ({yellow}Default{reset})".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}open{reset}:{green}file{reset}\t\t\t {yellow}open the given{reset} '{green}file{reset}' {yellow}for{reset} '{cyan}write{reset}:{green}text{reset}' {yellow}or{reset} '{cyan}append{reset}:{green}text{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}read{reset}:{green}file{reset}\t\t\t {yellow}read the contents of the given{reset} '{green}file{reset}' {yellow}to{reset} '{magenta}stdout{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}usage{reset}\t\t\t\t {yellow}show command line positions/usage for any{reset} {cyan}action{reset}".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}use{reset}:{green}path{reset}\t\t\t {yellow}use the given{reset} '{green}path{reset}' {yellow}for the search. The default is {reset}'{green}/{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}write{reset}:[{green}file{reset}|{green}text{reset}]\t\t {yellow}the{reset} '{green}file{reset}' {yellow}to be written to or the{reset} '{green}text{reset}' {yellow}that is written{reset}".fmt)
  stdout.flushFile

  stdout.writeLine("\n      :{green}file{reset}\t\t\t {yellow}for collecting data from{reset} '{cyan}find{reset}:{green}name{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n      :{green}text{reset}\t\t\t {yellow}data to be collected by{reset} '{cyan}open{reset}:{green}file{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}yield{reset}:{green}number{reset}\t\t\t {yellow}show an entry every{reset} '{green}number{reset}' {yellow}of miliseconds{reset}".fmt)
  stdout.flushFile

  stdout.writeLine(red, "\n―――――――――――――――――――――――――――――――――――――――――――", reset, "{", magenta, "superuser", reset, "}", red, "―――――――――――――――――――――――――――――――――――――――――――\n", reset)
  stdout.flushFile
  quit(0)
