

            ███████╗██╗   ██╗██████╗ ███████╗██████╗ ██╗   ██╗███████╗███████╗██████╗ 
            ██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗██║   ██║██╔════╝██╔════╝██╔══██╗
            ███████╗██║   ██║██████╔╝█████╗  ██████╔╝██║   ██║███████╗█████╗  ██████╔╝
            ╚════██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗██║   ██║╚════██║██╔══╝  ██╔══██╗
            ███████║╚██████╔╝██║     ███████╗██║  ██║╚██████╔╝███████║███████╗██║  ██║
            ╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝

                    🔋🔧 A simple, yet powerful tool in the hands of any user


# About
**Superuser** is meant to be a *multi-purpose* tool and combines the functionality of *five* fundamental Linux tools, such as:
1. **cat**
2. **echo**
3. **find**
4. **ls**
5. **touch**

Though each of tools are **custom versions** of the originals and may not have the same name or function the same.

# Installation (  )
**NOTE: building Superuser on Windows will be different from that of Linux and MacOS**

**choosenim**: [nim website](https://nim-lang.org/install_unix.html) and follow the instructions for you system.

**choosenim**: [GitHub](https://github.com/dom96/choosenim) (***Recomended***)

**musl-gcc** : [toolchain](https://musl.cc/) and [wiki](https://wiki.musl-libc.org/getting-started.html).

To install **Superuser** follow the instructions below:

<code>git clone https://github.com/sneekyfoxx/Superuser ~/ && cd ./Superuser/</code>

<code>nim --gcc.exe:musl-gcc --linker.exe:musl-gcc --passL:-static --threads:on --opt:speed -d:Release --out:superuser compile --run Main.nim</code>

<code>mv ./superuser your/location/of/choice` (make sure the location is on the **PATH**)</code>

Run the command <code>superuser actions</code> or <code>superuser usage</code>


**If you find this program useful please consider giving the repository a 🌟**

**Thank you!**
