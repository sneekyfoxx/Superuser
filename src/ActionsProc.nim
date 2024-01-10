import strformat, terminal

const
  red: string = "\e[1;31m"
  green: string = "\e[1;32m"
  yellow: string = "\e[1;33m"
  blue: string = "\e[1;34m"
  magenta: string = "\e[1;35m"
  cyan: string = "\e[1;36m"
  white: string = "\e[37m"
  reset: string = "\e[0m"


proc actions* {.noreturn.} =

  const banner: string = """
███████╗██╗   ██╗██████╗ ███████╗██████╗ ██╗   ██╗███████╗███████╗██████╗ 
██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██║   ██║██╔════╝██╔════╝██╔══██╗
███████╗██║   ██║██████╔╝█████╗  ██████╔╝██║   ██║███████╗█████╗  ██████╔╝
╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗██║   ██║╚════██║██╔══╝  ██╔══██╗
███████║╚██████╔╝██║     ███████╗██║  ██║╚██████╔╝███████║███████╗██║  ██║
╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝
  """


  stdout.write("\n{white}{banner}{reset}".fmt)
  stdout.flushFile()

  stdout.write("\n🔋🔧{yellow}A simple, yet powerful tool in the hands of any user.{reset}\n".fmt)
  stdout.flushFile()

  stdout.write("\n{green}Action\t\t\t\tDescription{reset}\n‾‾‾‾‾‾\t\t\t\t‾‾‾‾‾‾‾‾‾‾‾\n".fmt)
  stdout.flushFile()

  stdout.write(" {cyan}actions{reset}\t\t\t {yellow}show info for all{reset} {magenta}superuser{reset} {yellow}actions{reset}\n".fmt)
  stdout.flushFile()

  stdout.write("\n {cyan}echo{reset}:{green}text{reset}\t\t\t {yellow}output{reset} '{green}text{reset}' ".fmt)
  stdout.write("({red}default is{reset} '{green}stdout{reset}')\n".fmt)
  stdout.write("     {cyan}write{reset}:{green}text{reset}\t\t\t {yellow}write{reset} '{green}text{reset}' {yellow}to{reset} '{green}file{reset} ".fmt)
  stdout.write("({red}overwrites file contents{reset})\n".fmt)
  stdout.flushFile()

  stdout.write("\n {cyan}list{reset}[:{green}directory{reset}]\t\t {yellow}list the entries in the specified{reset} ".fmt)
  stdout.write("'{green}directory{reset}' ({red}default is{reset} '{green}./{reset}')\n".fmt)
  stdout.write("     {cyan}match{reset}:{green}name{reset}\t\t\t {yellow}match an entry{reset} '{green}name{reset}'\n\n".fmt)
  stdout.write("     {cyan}yield{reset}:{green}rate{reset}\t\t\t {yellow}show an entry per the given{reset} '{green}rate{reset}' ".fmt)
  stdout.write("({red}float{reset} {yellow}or{reset} {red}integer{reset})\n".fmt)
  stdout.flushFile()

  stdout.write("\n {cyan}count{reset}[:{green}directory{reset}]\t\t {yellow}recursively count all entries in {reset}".fmt)
  stdout.write("'{green}directory{reset}' ({red}default is{reset} '{green}./{reset}')\n".fmt)
  stdout.flushFile()

  stdout.write("\n {cyan}info{reset}:{green}entry{reset}\t\t\t {yellow}get information on a {reset}{blue}File{reset} ".fmt)
  stdout.write("{yellow}or{reset} {blue}Directory{reset} '{green}entry{reset}'\n".fmt)
  stdout.flushFile()

  stdout.write("\n {cyan}search{reset}[:{green}path{reset}]\t\t\t {yellow}search within{reset} '{green}path{reset}' ({red}default is{reset} '{green}/{reset}')\n".fmt)
  stdout.write("     {cyan}name{reset}:{green}entry{reset}\t\t\t {yellow}the entry to search for{reset}\n\n".fmt)
  stdout.write("     {cyan}mode{reset}:[{green}passive{reset}|{green}strict{reset}]\t {yellow}method used for finding{reset} '{green}name{reset}'\n".fmt)
  stdout.write("         {green}passive{reset}\t\t {yellow}find all paths containing{reset} '{green}name{reset}'\n\n".fmt)
  stdout.write("         {green}strict{reset}\t\t\t {yellow}find all paths ending in{reset} '{green}name{reset}'. ({red}default{reset})\n\n".fmt)
  stdout.write("     {cyan}limit{reset}:{green}number{reset}\t\t {yellow}limit the finds to{reset} '{green}number{reset}' ".fmt)
  stdout.write("({red}must be a positive integer{reset})\n\n".fmt)
  stdout.write("     {cyan}write{reset}:{green}file{reset}\t\t\t {yellow}write results to{reset} '{green}file{reset} ".fmt)
  stdout.write("({red}overwrites file contents{reset})\n".fmt)
  stdout.flushFile()

  stdout.write("\n {cyan}join{reset}:{green}file1{reset},{green}file2{reset}[,{green}...{reset}]\t\t ".fmt)
  stdout.write("{yellow}join the contents of multiple files into{reset} '{green}file1{reset}'\n".fmt)
  stdout.write("     {cyan}write{reset}:{green}file{reset}\t\t\t {yellow}write all contents to{reset} '{green}file{reset} ".fmt)
  stdout.write("({red}overwrites file contents{reset})\n".fmt)
  stdout.flushFile()

  stdout.write("\n {cyan}open{reset}:{green}file{reset}\t\t\t {yellow}open the given{reset} '{green}file{reset}'\n".fmt)
  stdout.write("     {cyan}append{reset}:{green}text{reset}\t\t {yellow}write{reset} '{green}text{reset} {yellow}to the end of '{green}file{reset}'\n\n".fmt)
  stdout.write("     {cyan}write{reset}:{green}text{reset}\t\t\t {yellow}write{reset} '{green}text{reset}' {yellow}to{reset} '{green}file{reset} ".fmt)
  stdout.write("({red}overwrites file contents{reset})\n".fmt)
  stdout.flushFile()

  stdout.write("\n {cyan}read{reset}:{green}file{reset}\t\t\t {yellow}read the contents of{reset} '{green}file{reset}' ".fmt)
  stdout.write("{yellow}to{reset} '{magenta}stdout{reset}'\n".fmt)
  stdout.flushFile()

  stdout.write("\n {cyan}usage{reset}\t\t\t\t {yellow}show command line positions/usage for any{reset} {cyan}action{reset}\n".fmt)
  stdout.flushFile()

  quit(0)
