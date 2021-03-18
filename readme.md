# Welcome

This is a Netwide Assembler work to recreate (_and reinterpret_) some of the **Standard C Libraries**.

This work started for learning assembly language with NASM. I hope it can help me to understand basics of assembly language and inspire others who wants to learn NASM or any other assembly language.

## Folder Structure

### ./source

Source is containing whole source code of this project. All object files are assembled from here.

Source has 3 sub folder

**standard:** 'standard' contains standard C Library files.

**extended:** 'extended' contains extended C Library files. all extended procedures has '\_x' suffix in them and they are all have some extended features.

**new:** 'new' contains new procedure files designed by me. There are some useful procedures in it.

### ./examples

example usage of some libraries

### ./tools

Basically whole system is created around my working environment but it does not constitute an obstacle.

There is only one thing you need to modify, the **lib_path** in **/tools/basm.bash** and **/tools/makelib.bash** file. it is default by **$HOME/assembly/lib** but you can change to anywhere just these tools needs to know where it is.

There is a separate **readme.md** file in tools check it out.

### ./lib

library folder to contain all object files

### ./learning

some of my notes about NASM syntax and definitions

### ./workspace

There are some other simple programs like argument reading and echo. it is mostly containing early stages of my learning.

## Usage

To use a .asm file in your c code.

```bash
    # compile it with nasm (32 bit compile recommended)
    nasm -f elf32 <as_file.asm> -o <out_name.o>

    # then link it to you c code with gcc
    gcc -m32 <your_c_file.c> -o <executable_name> <out_name.o>

    # run the executable
    ./<executable_name>
```

Example:
I have a strlen.asm file
and I am gonna use it in my source.c file

strlen.asm:

```asm
    section .text
        global strlen

    strlen:
        push ebp
        mov ebp, esp
        ; std prologue

        mov ecx, [ebp + 8]        ; reading string pointer from stack.
        xor eax, eax              ; reset eax to zero. now on it is gonna keep the char count.
        jmp compare               ; jump to comparison line

    loop:
        inc eax                   ; inc counter by one
    compare:
        cmp byte [ecx + eax], 0   ; dereference string pointer + exa to get value of char.
        jne loop                  ; jump to loop if its not a null terminator (0)

        ; std epilogue
        mov esp, ebp
        pop ebp
        ret
```

source.c:

```c
    #include <stdio.h>

    int strlen(char *);

    void main() {
        char *string = "hello world";
        int string_length = strlen(string);
        printf("string_length: %i\n", string_length);
    }
```
