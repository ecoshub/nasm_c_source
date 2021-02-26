section .data
    source          db      "hello world of assembly", 0
    source_len      equ     $-source
section .bss
    destination     resb    255

section .text
    extern strcpy
    global _start

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    call print_source
    call new_line
    call print_destination
    call new_line

    push destination
    push source
    call strcpy
    lea esp, [esp + 4]

    call print_source
    call new_line
    call print_destination
    call new_line


    ; std epilogue
    mov esp, ebp
    pop ebp
    nop

    mov eax, 1
    mov ebx, 0
    int 80h


new_line:
    push 10
    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 1
    int 80h
    pop eax
    ret

print_source:
    mov eax, 4
    mov ebx, 1
    mov ecx, source
    mov edx, source_len
    int 80h
    ret

print_destination:
    mov eax, 4
    mov ebx, 1
    mov ecx, destination
    mov edx, source_len
    int 80h
    ret
