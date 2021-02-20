section .data
    number db "-98514",0
section .bss

section .text
    extern atoi
    extern printreg
    global _start

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    push number
    call atoi
    add esp, 4

    call printreg

    ; std epilogue
    mov esp, ebp
    pop ebp
    nop

    mov eax, 1
    mov ebx, 0
    int 80h
