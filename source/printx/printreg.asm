; ----------------------------------------------------------
; Name.........: printreg
; Author.......: eco
; Date.........: 16.02.2021
; Arguments....: null
; Parameters...: null
; Modifiers....: null
; Returns......: null
; Description..: prints the register (eax ebx ecx edx ebp esi edi) values base 10
; ----------------------------------------------------------


section .data
    sep db " ------------------------- ", 10, 0     ; separator to
    sep_len equ $-sep                               ; calculate separator length
    registers db "eaxebxecxedxebpediesi"            ; string the contains all register names
    reg_sep db ": "                                 ; register separator string after every register
    reg_sep_len equ $-reg_sep                       ; calculate register separator length

section .bss
    cursor resb 1                                   ; cursor that olds the register name string index

section .text
    extern printx
    global printreg

printreg:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    pushad                          ; store all registers to restore later

    ; push parameters for print it in base 10
    push 10
    push esi
    ; push parameters for print it in base 10
    push 10
    push edi
    ; push parameters for print it in base 10
    push 10
    push ebp
    ; push parameters for print it in base 10
    push 10
    push edx
    ; push parameters for print it in base 10
    push 10
    push ecx
    ; push parameters for print it in base 10
    push 10
    push ebx
    ; push parameters for print it in base 10
    push 10
    push eax


    ; prints separator
    mov eax, 4
    mov ebx, 1
    mov ecx, sep
    mov edx, sep_len
    int 80h

    mov byte [cursor], 0            ; reset the register name cursor

    jmp printreg.compare                     ; start with comparison


.loop:
    ; print register name
    mov eax, 4
    mov ebx, 1
    mov ecx, [cursor]               ; cursor holds the register name info
    lea ecx, [registers+ecx*3]      ; mult. with 3 because every register name is 3 char
    mov edx, 3                      ; print 3 char
    int 80h

    ; print register separator
    mov eax, 4
    mov ebx, 1
    mov ecx, reg_sep
    mov edx, reg_sep_len
    int 80h

    call printx                     ; print register in stack
    lea esp , [esp + 8]             ; pop parameters

    push 10                         ; push newline char to stack

    ; print register separator
    mov eax, 4
    mov ebx, 1
    mov ecx, esp                    ; now esp points the newline char (10)
    mov edx, 1
    int 80h     

    pop eax                         ; pop new line char from stack

    inc byte [cursor]               ; increment cursor value by one

.compare:
    cmp byte [cursor], 7            ; there is 7 register to print
    jne printreg.loop               ; if cursor in not in last keep looping

    ; print separator
    mov eax, 4
    mov ebx, 1
    mov ecx, sep
    mov edx, sep_len
    int 80h

    popad                           ; restore all registers from stack

    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
