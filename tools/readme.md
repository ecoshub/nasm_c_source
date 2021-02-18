## basm

abbreviation for 'build asm'

Use basm.bash to assemble a .asm file and linking it with specified libs.

lib_path is "/home/eco/assembly/lib"

```bash
    ./basm.bash file.asm printx
```

assemble .asm file and link it with printx.o. It assumes that 'printx.o' file is in 'lib_path')

## makelib

Use makelib.bash to assemble a lib file.

```bash
    ./makelib.bash file.asm
```

## restore.bash

Restores basm and makelib files in /usr/bin.

## toasm

C to asm. converts c file to asm file

```bash
    ./toasm.bash file.c

    # output: file.s
```
