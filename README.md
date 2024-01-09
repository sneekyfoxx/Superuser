            ███████╗██╗   ██╗██████╗ ███████╗██████╗ ██╗   ██╗███████╗███████╗██████╗ 
            ██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██║   ██║██╔════╝██╔════╝██╔══██╗
            ███████╗██║   ██║██████╔╝█████╗  ██████╔╝██║   ██║███████╗█████╗  ██████╔╝
            ╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗██║   ██║╚════██║██╔══╝  ██╔══██╗
            ███████║╚██████╔╝██║     ███████╗██║  ██║╚██████╔╝███████║███████╗██║  ██║
            ╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝
    
                    🔋🔧 A simple, yet powerful tool in the hands of any user

# About

**Superuser** is meant to be a *multi-purpose* tool and combines the functionality of *five* fundamental Linux tools such as **cat**, **echo**, **find**, **ls**, and **touch**.

Each tool that is a part of **Superuser** are ***custom versions*** of the originals and may not have the same name or function (*exactly*) the same.

# Platforms

**Superuser** was only tested on ***Archcraft x86_64 Linux 6.6.9-arch1-1*** but should work on any x86_64 Linux or MacOS machine.

As for **Windows**, I'm unsure about how to build the binary using **Nim**, so it may take some extra work.

# Requirements

## choosenim

**website**: [https://nim-lang.org/install_unix.html](https://nim-lang.org/install_unix.html)

**github**: (*Recommended*) [https://github.com/dom96/choosenim](https://github.com/dom96/choosenim)

## musl-gcc

**website**: [https://musl.cc/](https://musl.cc/)

**wiki**: [https://wiki.musl-libc.org/getting-started.html](https://wiki.musl-libc.org/getting-started.html).

## upx compression utility (*optional*)

Install using your system package manager.

# Manual Installation

**Make sure you've installed the correct musl-gcc toolchain for your system**

```bash
$ choosenim update stable
$ git clone https://github.com/sneekyfoxx/Superuser ~/ && cd ~/Superuser/
$ nim --gcc.exe:musl-gcc --linker.exe:musl-gcc --passL:-static --threads:on --opt:speed -d:Release --out:superuser compile ./src/Main.nim
$ mv ./superuser your/location/of/choice
```

When moving the binary file, make sure the chosen location is on your **PATH**.

You can also use **upx** or any other binary compression program to reduce the file size.

# Using The Build Script

```
$ choosenim update stable
$ git clone https://github.com/sneekyfoxx/Superuser ~/ && cd ~/Superuser
$ ./build.sh -c -b -s -i
```

After installation, I recommend executing the following commands:

- **superuser actions**: for information about parameters and arguments
- **superuser usage**:   for a list of all command-usage patterns

**If you find this program useful please consider giving the repository a ⭐**

**Thank you!**
