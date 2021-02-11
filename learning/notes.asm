section .data

section .bss

section .text
    global _start

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    ; std epilogue
    mov esp, ebp
    pop ebp
    nop

    ; popping arguments in stack
    ; method 1
    add esp, 4
    ; method 2
    lea esp, [esp + 4]
    ; method 3
    pop eax
