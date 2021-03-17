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
    push ebp
    mov ebp, esp
    ; std prologue

    mov ecx, [ebp + 8]              ; reading string pointer from stack.
    xor eax, eax                    ; reset eax to zero. now on it is gonna keep the char count.
    jmp compare                     ; jump to comparison line

loop:
    inc eax                         ; inc counter by one
compare:
    cmp byte [ecx + eax], 0         ; dereference string pointer + exa to get value of char. 
    jne loop                        ; jump to loop if its not a null terminator (0)

    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
