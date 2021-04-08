section .data
    char    db    'a'
section .bss

section .text
    global _start
    extern isalnum
    extern isdigit
    extern isalpha

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    ; eax holds the char value
    ; ebx is the result
    ; ecx is the return point (link pointer)


    mov al, byte [char]
    call isalpha
    call print_ebx


    mov al, byte [char]
    call isdigit
    call print_ebx

    mov al, byte [char]
    call isalnum
    call print_ebx

    ; std epilogue
    mov esp, ebp
    pop ebp
    nop

    jmp exit


print_ebx:
    add ebx, 0x30
    push ebx
    
    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 1
    int 0x80

    lea esp, [esp + 4]
    ret

exit:
    mov eax, 1
    mov ebx, 0
    int 0x80
