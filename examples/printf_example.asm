section .data
    string      db      "name: %s, age: %d, lastname: %s, float_number: %x, float_number: %X", 0
    name        db      "eco", 0
    lastname    db      "hub", 0
    age         dd      29
    float_number      dd      0xFF00FF
section .bss

section .text
    extern printf
    global _start

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    push float_number
    push float_number
    push lastname
    push age
    push name
    push string

    call printf
    lea esp, [esp + 24]

    ; std epilogue
    mov esp, ebp
    pop ebp
    nop

    mov eax, 1
    mov ebx, 0
    int 0x80
