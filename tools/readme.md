## basm

abbreviation for 'build asm'

Use basm.bash to assemble a .asm file and linking it with specified libs.

**lib_path** is "/home/eco/assembly/lib"

```bash
    ./basm.bash file.asm printf
```

this assembles **file.asm** file and links it with **printf.o**. It assumes that **printf.o** is in **lib_path**

## makelib

Use makelib.bash to assemble a lib file.

```bash
    ./makelib.bash file.asm
```

creates two **.o** files. one with debugging info and one without.

debugger included file has **_dbg** suffix.

## restore.bash

Restores basm and makelib files in **/usr/bin** if exists.

## toasm

C to asm

converts a c file to asm file

```bash
    ./toasm.bash file.c

    # output: file.s
```

# source_all.bash

get all source files that has '.asm' extension recursively and perform 'makelib.bash' to each one of them to create object files.

```bash
    ./source_all.bash

    # output: file.s
```
