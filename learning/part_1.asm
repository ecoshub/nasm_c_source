section .data
    msg: db "hello world",10
section .bss

section .text
    global _start

_start:
    nop
    ; mov
    mov eax, 30ch   ; move constant number to to eax.
    mov ebx, eax    ; move eax value to ebx
    mov ecx, 'ABC'  ; move value of 'ABC' to ecx. in little endian format so A is the lsb and C is the msb here
    mov dl, [msg]   ; move first byte to dl which 'msg' points
    
    ; xchg
    xchg ah,al      ; exchanges high byte with low byte of a

    ; resetting all tree registers
    xor ecx, ecx
    xor ebx, ebx
    xor eax, eax

    ; workspace
    mov ax, 067FEH
    mov bx, ax
    mov cl, bh
    mov ch, bl
    nop

    ; close program with exit code 0
    mov eax, 1
    mov ebx, 0
    int 80H
