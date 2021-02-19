; ----------------------------------------------------------
; Name.........: trim_example
; Author.......: eco
; Date.........: 18.02.2021
; Arguments....: null
; Parameters...: null
; Modifiers....: all registers
; Returns......: null
; Description..: prints the message and prints the trimmed version of string
; ----------------------------------------------------------


section .data
    message     db "              hello world              ", 0
section .bss

section .text
    extern trim_space
    extern strlen
    extern printreg

    global _start

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    ; print string
    call print_string

    push message
    call trim_space
    lea esp, [esp + 4]

    ; print string
    call print_string

    ; std epilogue
    mov esp, ebp
    pop ebp
    nop

    ; std exit call
    mov eax, 1
    mov ebx, 0
    int 80h

; print the string
print_string:

    ; print > symbol at the start
    mov eax, '>'
    call print_symbol

    ; get the string length
    push message
    call strlen
    lea esp, [esp + 4]

    ; string length is in eax move it to edx
    mov edx, eax

    ; std print interrupt
    mov eax, 4
    mov ebx, 1
    mov ecx, message
    int 80h

    ; print < symbol at the end
    mov eax, '<'
    call print_symbol
    
    ; print new line element
    mov eax, 10
    call print_symbol

    ret

print_symbol:
    ; assumes symbol is in eax.
    ; push symbol to stack so esp point to it
    push eax
    ; std print interrupt
    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 1
    int 80h
    ; pop symbol to restore stack
    pop eax
    ret
