# Welcome

This a Netwide Assembler work to recreate core c libraries with NASM

This work started as learning NASM. I hope it can help me to understand basics of assembly language and inspire others who wants to learn NASM or any other assembly language.

## Folder Structure

### tools

Basically whole system is created around my working environment but it does not constitute an obstacle.

First you need to modify the **lib_path** in **.env** file. it is default by **$HOME/assembly/lib** but you can change to anywhere just tools needs to know where it is.

There is a separate **readme.md** file in tools check it out.

### lib

library folder to contain all object files

### source

Source is containing whole source code of this project. All object files in lib is assembled from here.

### learning

some of my notes

### workspace

There are some other simple programs like argument reading and echo. it is mostly containing early stages of my learning.

### examples

example usage of some libraries
