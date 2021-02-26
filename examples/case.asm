section .data

section .bss

section .text
    extern toupper
    extern tolower
    extern printreg
    global _start

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    xor eax, eax
    mov al, 'A'
    
    call printreg

    push eax
    call tolower
    lea esp, [esp + 4]

    call printreg

    push eax
    call toupper
    lea esp, [esp + 4]

    call printreg

    ; std epilogue
    mov esp, ebp
    pop ebp
    nop

    mov eax, 1
    mov ebx, 0
    int 80h
