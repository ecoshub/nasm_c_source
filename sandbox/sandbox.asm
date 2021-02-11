section .data

section .bss

section .text

    extern printx

    global _start

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax, 30
    mov ebx, 10

    push ebx
    push eax
    call printx

    mov eax, 1
    mov ebx, 0
    int 80H
