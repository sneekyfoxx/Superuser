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

  stdout.write("\n", blue, "Author", reset, ": ", magenta, "Rayshawn Levy", reset, "\n")
  stdout.flushFile

  stdout.writeLine("\n{yellow}A simple, yet powerful tool in the hands of any user.{reset}\n".fmt)
  stdout.flushFile

  stdout.write("{blue}NOTE{reset}: {yellow}{red}/{reset}{yellow}'s and {reset}{red}\\{reset}".fmt)
  stdout.write("{yellow}'s in any{reset} '{green}name{reset}' {yellow}given as an argument to{reset} ".fmt)
  stdout.write("{cyan}find:{reset}{yellow} is{reset} {red}invalid.{reset}\n".fmt)
  stdout.flushFile

  stdout.writeLine("\n{green}Action\t\t\t\tDescription{reset}\n‾‾‾‾‾‾\t\t\t\t‾‾‾‾‾‾‾‾‾‾‾".fmt)
  stdout.flushFile

  stdout.writeLine(" {cyan}actions{reset}\t\t\t {yellow}show info for all{reset} {magenta}superuser{reset} {yellow}actions{reset}\n".fmt)
  stdout.flushFile

  stdout.write(" {cyan}append{reset}:{green}text{reset}\t\t\t '{green}text{reset} ".fmt)
  stdout.write("{yellow}is added to the end of{reset} '{cyan}open{reset}:{green}file{reset}'\n".fmt)
  stdout.flushFile

  stdout.write("\n {cyan}echo{reset}:{green}text{reset}\t\t\t '{green}text{reset}' {yellow}that is collected and sent to{reset} ".fmt)
  stdout.write("'{magenta}stdout{reset}' {yellow}or to{reset} '{cyan}write{reset}:{green}file{reset}'\n".fmt)

  stdout.write("\n {cyan}entries{reset}[:{green}directory{reset}]\t\t {yellow}list the entries in the specified{reset} ".fmt)
  stdout.write("'{green}directory{reset}'. {yellow}The default is{reset} '{green}./{reset}'\n".fmt)
  stdout.flushFile

  stdout.write("\n {cyan}entrycount{reset}[:{green}directory{reset}]\t\t {yellow}recursively count all entries in {reset}".fmt)
  stdout.write("'{green}directory{reset}'. {yellow}The default is{reset} '{green}./{reset}'\n".fmt)
  stdout.flushFile

  stdout.write("\n {cyan}entryinfo{reset}:{green}entry{reset}\t\t {yellow}get information on a {reset}{blue}File{reset} ".fmt)
  stdout.write("{yellow}or{reset} {blue}Directory{reset} '{green}entry{reset}'\n".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}find{reset}:{green}name{reset}\t\t\t {yellow}search the filesystem for the given{reset} '{green}name{reset}'\n".fmt)
  stdout.flushFile

  stdout.write(" {cyan}join{reset}:{green}file1{reset},{green}file2{reset}[,{green}...{reset}]\t\t ".fmt)
  stdout.write("{yellow}join the contents of multiple files into{reset} '{green}file1{reset}' {yellow}or{reset} '{cyan}write{reset}:{green}file{reset}'\n".fmt)
  stdout.flushFile

  stdout.write("\n {cyan}limit{reset}:{green}number{reset}\t\t\t {yellow}limit the finds to{reset} '{green}number{reset}' ".fmt)
  stdout.write("({red}must be positive{reset})\n".fmt)
  stdout.flushFile

  stdout.write("\n {cyan}match{reset}:{green}name{reset}\t\t\t {yellow}match an entry{reset} '{green}name{reset}' ".fmt)
  stdout.write("{yellow}when listing directory entries{reset}\n".fmt)
  stdout.flushFile

  stdout.write("\n {cyan}mode{reset}:[{green}passive{reset}|{green}strict{reset}]\t\t {yellow}set the search state to{reset} ".fmt)
  stdout.write("'{green}passive{reset}' {yellow}or{reset} '{green}strict{reset}'\n".fmt)
  stdout.flushFile

  stdout.writeLine("     {green}passive{reset}\t\t\t {yellow}find all paths containing{reset} '{green}name{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("     {green}strict{reset}\t\t\t {yellow}find all paths ending in{reset} '{green}name{reset}'. ({yellow}Default{reset})".fmt)
  stdout.flushFile

  stdout.write("\n {cyan}open{reset}:{green}file{reset}\t\t\t {yellow}open the given{reset} '{green}file{reset}' ".fmt)
  stdout.write("{yellow}for{reset} '{cyan}write{reset}:{green}text{reset}' {yellow}or{reset} '{cyan}append{reset}:{green}text{reset}'\n".fmt)
  stdout.flushFile

  stdout.write("\n {cyan}read{reset}:{green}file{reset}\t\t\t {yellow}read the contents of the given{reset} ".fmt)
  stdout.write("'{green}file{reset}' {yellow}to{reset} '{magenta}stdout{reset}'\n".fmt)
  stdout.flushFile

  stdout.writeLine("\n {cyan}usage{reset}\t\t\t\t {yellow}show command line positions/usage for any{reset} {cyan}action{reset}\n".fmt)
  stdout.flushFile

  stdout.write(" {cyan}use{reset}:{green}path{reset}\t\t\t {yellow}use the given{reset} '{green}path{reset}' ".fmt)
  stdout.write("{yellow}for the search. The default is {reset}'{green}/{reset}'\n".fmt)
  stdout.flushFile

  stdout.write("\n {cyan}write{reset}:[{green}file{reset}|{green}text{reset}]\t\t {yellow}the{reset} ".fmt)
  stdout.write("'{green}file{reset}' {yellow}to be written to or the{reset} '{green}text{reset}' {yellow}that is written{reset}\n".fmt)
  stdout.flushFile

  stdout.writeLine("      {green}file{reset}\t\t\t {yellow}for collecting data from{reset} '{cyan}find{reset}:{green}name{reset}'".fmt)
  stdout.flushFile

  stdout.writeLine("      {green}text{reset}\t\t\t {yellow}data to be collected by{reset} '{cyan}open{reset}:{green}file{reset}'\n".fmt)
  stdout.flushFile

  stdout.writeLine(" {cyan}yield{reset}:{green}miliseconds{reset}\t\t {yellow}show an entry per{reset} '{green}miliseconds{reset}'\n".fmt)
  stdout.flushFile

  quit(0)
