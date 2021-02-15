section .data
    message db "hello WORLD", 10, 0
    len equ $-message
section .bss

section .text

    extern printx
    extern to_upper
    extern to_lower

    global _start

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, len
    int 80h

    push message
    call to_upper
    add esp, 4 

    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, len
    int 80h

    push message
    call to_lower
    add esp, 4 

    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, len
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80H
