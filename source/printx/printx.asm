; ----------------------------------------------------------
; Name.........: printx (print extended)
; Author.......: eco
; Date.........: 11.02.2021
; Arguments....: null
; Parameters...: one dword to print
; Modifiers....: all registers
; Returns......: null
; Description..: prints the base 10 value of given dword
; ----------------------------------------------------------


section .data
    hex_list db "0123456789ABCDEF"

    sys_write     equ     4
    stdout        equ     1

section .bss
    number_pointer resb 1

section .text
    global printx

printx:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax, [ebp + 8]            ; value to print. reading argument from stack..
    mov ebx, [ebp + 12]           ; number base to print. reading argument from stack.

    mov ecx, 255                  ; 255 is a arbitrary number to define start of stack
    push ecx                      ; push 0 to stack for EOL (null terminator)
    xor ecx, ecx                  ; clear ecx

.bcd_loop:                        ; convert integer value to bcd
    xor edx, edx                  ; clear edx. it will contain reminder
    div ebx                       ; divide exa to ebx
    push edx                      ; push reminder to stack
    cmp eax, 0                    ; compare reminder to zero
    jnz printx.bcd_loop            ; jump to divide routine if reminder is not zero

.print_loop:
    pop eax                       ; pop reminder from stack
    cmp eax, 255                  ; compare with 255 (255 is a arbitrary number stored as initial stack value)
    je close                      ; if its zero than print a newline and terminate the program
    mov byte [number_pointer], al ; al holds the bcd of number store it in to number_pointer to print.
    call to_hex                   ; convert value in the number_pointer to string value
    call print_number             ; print the number
    jmp printx.print_loop          ; restart the print routine

to_hex:
    xor eax, eax                  ; clear eax
    mov al, byte [number_pointer] ; load number value to al
    mov eax, [hex_list+eax]       ; add number to hex_list address it will convert integer value to string value
    mov [number_pointer], eax     ; load number pointer with converted value
    ret

print_number:
    ; std print system call
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, number_pointer
    mov edx, 1
    int 80h
    ret

close:
    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
