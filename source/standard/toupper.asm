; ----------------------------------------------------------
; Name.........: toupper
; Author.......: eco
; Date.........: 26.02.2021
; Arguments....: null
; Parameters...: a char given with stack
; Modifiers....: eax
; Returns......: upper version of given char
; Description..: converts lowercase char to uppercase char and stores result in eax
; ----------------------------------------------------------


section .data

section .bss

section .text
    global toupper

toupper:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax , [ebp + 8]     ; read char from stack

    cmp eax, 0x61           ; if below 'a'
    jb end                  ; jump to end
    cmp eax, 0x7A           ; if above 'z'
    ja end                  ; jump to end
    sub eax, 0x20           ; convert it to uppercase

end:
    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
