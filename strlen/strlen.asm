; ----------------------------------------------------------
; Name.........: strlen (string length)
; Author.......: eco
; Date.........: 11.02.2021
; Arguments....: null
; Parameters...: one pointer to first element of string
; Modifiers....: all registers
; Returns......: length of the string with eax
; Description..: returns the length of the given string
; ----------------------------------------------------------


section .text
    global strlen

strlen:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov ecx, [ebp + 8]              ; value to find string length. reading argument from stack..
    xor eax, eax                    ; reset eax

.loop:
    cmp byte [ecx + eax], 0           ; dereference exa to get value of string that position in 
    jz .done                        ; done if content is zero
    inc eax                         ; inc cursor one byte
    jmp .loop                       ; repeat

.done:
    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
