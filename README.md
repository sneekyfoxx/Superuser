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

**choosenim**: [nim website](https://nim-lang.org/install_unix.html) or (***Recommended***) [GitHub](https://github.com/dom96/choosenim)

**musl-gcc** : [toolchain](https://musl.cc/) and [wiki](https://wiki.musl-libc.org/getting-started.html).

# Installation

To install **Superuser** follow the instructions below:

```bash
$ git clone https://github.com/sneekyfoxx/Superuser $HOME && cd $HOME/Superuser/
$ nim --gcc.exe:musl-gcc --linker.exe:musl-gcc --passL:-static --threads:on --opt:speed -d:Release --out:superuser compile Main.nim
$ mv ./superuser your/location/of/choice
```

When moving the binary file, make sure the chosen location is on your **PATH**.

Then, execute the command '**superuser actions**' for information on parameters or '**superuser usage**' for command usage information.

**If you find this program useful please consider giving the repository a 🌟**

**Thank you!**
