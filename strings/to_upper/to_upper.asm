; ----------------------------------------------------------
; Name.........: to_upper
; Author.......: eco
; Date.........: 11.02.2021
; Arguments....: null
; Parameters...: one string pointer passed from stack
; Modifiers....: eax, ebx
; Returns......: null
; Description..: converts all lowercase chars to uppercase in given string pointer
; ----------------------------------------------------------


section .text
    global to_upper:

to_upper:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax, [ebp + 8]          ; read parameter from stack
    dec eax                     ; to constantly increment in loop just decrementing one 
                                ; on the first step it will be on right place
.loop:
    inc eax                     ; point next byte
    mov bl, byte [eax]          ; move char from memory to register 
    cmp ebx, 0                  ; compare against zero (null terminator)
    jz to_upper.done            ; jump to done if end of string
    cmp ebx, 'a'                ; if below 'a' than its not a lowercase char
    jb to_upper.loop            ; skip the char
    cmp ebx, 'z'                ; if above 'z' than its not a lowercase char
    ja to_upper.loop            ; skip the char
    sub byte [eax], 20h         ; subtracting 20h makes lowercase char uppercase 
    jmp to_upper.loop           ; continue

.done:
    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
