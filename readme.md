# Standard C Libraries in NASM

This project aims to recreate some of the Standard C Libraries using the Netwide Assembler (NASM). It was created as a learning exercise to help me understand the basics of assembly language, and to inspire others who are interested in learning NASM or any other assembly language.

## Folder Structure


| Folder    | Description                                                                                                                                                 |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| source    | Contains the source code for the project, including subfolders for standard and extended C Library files, as well as new procedures designed by the author. |
| source/standard    | Contains standard C Library files. |
| source/extended    | Contains extended C Library files. These procedures have a '_x' suffix and have additional features. |
| source/new    | Contains new procedures designed by the author. There are some useful procedures in this folder. |
| examples  | Contains examples of how to use some of the libraries.                                                                                                      |
| tools     | Contains tools used to build the system. The `lib_path` in `basm.bash` and `makelib.bash` can be modified to change the default location.                     |
| lib       | Contains all the object files.                                                                                                                               |
| learning  | Contains notes about NASM syntax and definitions.                                                                                                            |
| workspace | Contains simple programs such as argument reading and echo, as well as the early stages of the author's learning process.                                      |


## Usage

To use a .asm file in your C code, follow these steps:

1) Compile it with NASM (32-bit compilation is recommended):

```bash
    nasm -f elf32 <as_file.asm> -o <out_name.o>
```

2) Link it to your C code using GCC:

```bash
    gcc -m32 <your_c_file.c> -o <executable_name> <out_name.o>
```

3) Run the executable:

```bash
    ./<executable_name>
```

To use the libraries in your own projects, you can either include the appropriate .asm files in your source code and assemble and link them as shown in the example above, or you can use the object files in the ./lib folder.

To use an object file, include the corresponding header file in your C code and link the object file when compiling.

For example, to use the strlen function from the string.h header file, you can do the following:


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

