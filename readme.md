# Welcome

This is a Netwide Assembler work to recreate (and reinterpret) some of the standard c libraries.

This work started for learning assembly language with NASM. I hope it can help me to understand basics of assembly language and inspire others who wants to learn NASM or any other assembly language.

## Folder Structure

### ./source

Source is containing whole source code of this project. All object files are assembled from here.

Source has 3 sub folder

**standard:** standard contains standard C Library files.

**extended:** extended contains extended C Library files. all extended procedures has '\_x' suffix in them and they are all has some extended features.

**new:** new contains new procedure files designed by me. There are some useful procedures in it.

### ./examples

example usage of some libraries

### ./tools

Basically whole system is created around my working environment but it does not constitute an obstacle.

There is only one thing you need to modify the **lib_path** in **/tools/basm.bash** and **/tools/makelib.bash** file. it is default by **$HOME/assembly/lib** but you can change to anywhere just these tools needs to know where it is.

There is a separate **readme.md** file in tools check it out.

### ./lib

library folder to contain all object files

### ./learning

some of my notes

### ./workspace

There are some other simple programs like argument reading and echo. it is mostly containing early stages of my learning.
