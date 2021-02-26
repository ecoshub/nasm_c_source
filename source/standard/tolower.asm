; ----------------------------------------------------------
; Name.........: tolower
; Author.......: eco
; Date.........: 26.02.2021
; Arguments....: null
; Parameters...: a char given with stack
; Modifiers....: eax
; Returns......: lower version of given char
; Description..: converts uppercase char to lower char and stores result in eax
; ----------------------------------------------------------


section .data

section .bss

section .text
    global tolower

tolower:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax , [ebp + 8]      ; read char from stack

    cmp eax, 0x41            ; if below 'a'
    jb end                   ; jump to end
    cmp eax, 0x5A            ; if above 'z'
    ja end                   ; jump to end
    add eax, 0x20            ; convert it to uppercase

end:
    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
