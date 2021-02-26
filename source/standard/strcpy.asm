; ----------------------------------------------------------
; Name.........: strcpy
; Author.......: eco
; Date.........: 26.02.2021
; Arguments....: null
; Parameters...: 2 string pointer given with stack. first is source and second is destination
; Modifiers....: all registers
; Returns......: null
; Description..: copies source content in to the destination
; ----------------------------------------------------------

section .data

section .bss

section .text
    global strcpy

strcpy:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax, [ebp + 8]          ; source string pointer
    mov ebx, [ebp + 12]         ; destination string pointer

    xor ecx, ecx                ; clear c to use as a counter
    
loop:
    mov dl, byte [eax+ecx]      ; get ecx'th char of source
    cmp dl, 0                   ; compare it with null terminator
    je end                      ; if its null jump to end
    mov byte[ebx+ecx], dl       ; move char that read from source to destination byte
    inc ecx                     ; increment counter
    jmp loop                    ; keep going

end:

    mov byte[ebx+ecx], 0        ; add a null terminator at the end of destination

    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
