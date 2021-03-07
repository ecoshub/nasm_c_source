; ----------------------------------------------------------
; Name.........: print_int
; Author.......: eco
; Date.........: 11.02.2021
; Arguments....: null
; Parameters...: one dword to print
; Modifiers....: all registers
; Returns......: null
; Description..: prints an integer in given base
; ----------------------------------------------------------


section .data
    hex_list db "0123456789ABCDEF"

    sys_write     equ     4
    stdout        equ     1
section .bss

section .text
    global print_int

print_int:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax, [ebp + 8]                      ; value to print. reading argument from stack..
    mov ebx, [ebp + 12]                     ; number base to print. reading argument from stack.

    xor ecx, ecx                            ; clear ecx, ecx is now stack counter

.bcd_loop:
    xor edx, edx                            ; clear edx. it will contain reminder
    div ebx                                 ; divide exa to ebx
    push edx                                ; push reminder to stack
    inc ecx                                 ; increment stack counter
    cmp eax, 0                              ; compare reminder to zero
    je print_int.cmp_done                   ; jump to divide routine if reminder is not zero
    jmp print_int.bcd_loop                  ; jump to comparison part

.print_loop:
    pop eax                                 ; pop reminder from stack
    mov eax, [hex_list+eax]                 ; add number to hex_list address it will convert integer value to string value
    call print_int.print_char               ; print the char in eax

.cmp_done:
    cmp ecx, 0                              ; compare stack count to zero
    je print_int.done                       ; if its zero that no more number to print jump done
    dec ecx                                 ; if its not zero decrement
    jmp print_int.print_loop                ; keep going

.print_char:
    pushad                                  ; store all registers
    push eax                                ; push value to print so esp points on it
    ; std print system call
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, esp
    mov edx, 1
    int 80h

    lea esp, [esp + 4]                      ; restore esp
    popad                                   ; restore all registers
    ret

.done:
    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
