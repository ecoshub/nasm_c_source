; ----------------------------------------------------------
; Name.........: tolower_x
; Author.......: eco
; Date.........: 11.02.2021
; Arguments....: null
; Parameters...: one string pointer passed with stack
; Modifiers....: eax, ebx
; Returns......: null
; Description..: extended edition of tolower. converts all uppercase chars to lowercase in given string pointer
; ----------------------------------------------------------


section .text
    global tolower_x:

tolower_x:
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
    jz tolower_x.done           ; jump to done if end of string
    cmp ebx, 'A'                ; if below 'A' than its not a uppercase char
    jb tolower_x.loop           ; skip the char
    cmp ebx, 'Z'                ; if above 'Z' than its not a uppercase char
    ja tolower_x.loop           ; skip the char
    add byte [eax], 20h         ; adding 20h makes uppercase char lowercase 
    jmp tolower_x.loop          ; continue

.done:
    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
