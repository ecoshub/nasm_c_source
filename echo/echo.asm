; -------------------------------------------------
; simple echo program.
; reads input from stdin and writes the same message to stdout
; -------------------------------------------------

section .data
    sys_exit      equ     1
    sys_read      equ     3
    sys_write     equ     4

    stdin         equ     0
    stdout        equ     1
    stderr        equ     3

    exit_normal   equ     0

section .bss
    buffer resb 1

section .text
    global _start

_start:
    nop

top:
    nop                     ; gdb nop
    call read_char          ; read one char and store it in buffer
    cmp byte [buffer], 10   ; exit if char is 10. 10 means EOL (ENTER)
    call print_buffer       ; print one char from buffer
    je exit                 ; exit is char is 10.
    jmp top                 ; jump to top and start reading chars again.
    nop                     ; gdb nop

; stdin. standard scan interrupt.
read_char:
    mov eax, sys_read
    mov ebx, stdin
    mov ecx, buffer
    mov edx, 1
    int 80h
    ret

; stdout. standard print interrupt.
print_buffer:
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, buffer
    mov edx, 1
    int 80h
    ret

; sys_exit
exit:
    mov eax, sys_exit
    mov ebx, exit_normal
    int 80h
