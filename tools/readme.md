## basm

abbreviation for 'build asm'

Use basm.bash to assemble a .asm file and linking it with specified libs.

It will automatically find .asm file and assemble it.

there is an executable in /usr/bin and there must be a alias for 'basm'

lib_path is "/home/eco/assembly/lib"

```bash
    ./basm.bash printx
```

assemble .asm file and link it with printx.o. It assumes that 'printx.o' file is in 'lib_path')

## makelib

Use makelib.bash to assemble a lib file.

It will automatically find .asm file and assemble it.

```bash
    ./makelib.bash
```

## restore.bash

Restores basm and makelib files in /usr/bin.

## toasm

C to asm. converts c file to asm file

```bash
    ./toasm.bash file.c

    # output: file.s
```

