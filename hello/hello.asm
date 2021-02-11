; ----------------------------------------------------------
; Name.........: hello
; Author.......: eco
; Date.........: 04.02.2021
; Arguments....: null
; Parameters...: null
; Modifiers....: all registers
; Returns......: null
; Description..: prints the 'hello world' string
; ----------------------------------------------------------


section .data
    msg db "hello world", 10
    msgLen equ $-msg

section .text

    global _start

_start:
    nop
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msgLen
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h
