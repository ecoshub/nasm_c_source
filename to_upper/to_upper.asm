section .data
    err_argc_not_valid db "argument count is not valid! this program only can prcess one argument at a time", 10, 0

    sys_exit      equ     1
    sys_read      equ     3
    sys_write     equ     4

    stdin         equ     0
    stdout        equ     1
    stderr        equ     3

    exit_normal   equ     0

section .bss
    error_pointer resd 1
    char_buffer resb 1

section .text
    global _start:

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax, dword [ebp + 4]        ; read argument count from first stack depth
    cmp eax, 2                      ; compare argc with 2 ( first argument is program name)
    push err_argc_not_valid         ; prepare err_argc_not_valid error for print
    jne print_error                 ; jump if argc is not 1 
    pop eax                         ; pop err_argc_not_valid if not jump it means it is still in the stack


    xor eax, eax
    mov eax, dword [ebp + 12]
    mov eax, dword [ebp + 16]
    mov eax, dword [ebp + 20]

    jmp exit



;     xor edx, edx
; is_alphabetic:
;     mov al, byte [char_buffer+edx]
;     cmp al, 0
;     je exit
;     cmp al, 41h
;     inc edx
;     jl is_alphabetic
;     cmp al, 5Ah
;     jg is_alphabetic
;     add al, 20h
;     call print_char
;     jmp is_alphabetic

    ; std epilogue
    mov esp, ebp
    pop ebp
    nop


print_error:
    mov eax, sys_write
    mov ebx, stderr
    pop ecx
    mov edx, 255
    int 80h
    call exit

print_char:
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, char_buffer
    int 80h
    ret

exit:
    mov eax, sys_exit
    mov ebx, exit_normal
    int 80h
    ret
