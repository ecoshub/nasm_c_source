SECTION .data
    msg: db "this is my first assembly program.",10
    msgLen: equ $-msg

SECTION .bss
SECTION .text

global _start

_start:
    nop
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msgLen
    int 80H

    mov eax, 1
    mov ebx, 0
    int 80H
