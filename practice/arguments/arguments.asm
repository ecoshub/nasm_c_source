; ----------------------------------------------------------
; Name.........: arguments
; Author.......: eco
; Date.........: 11.02.2021
; Arguments....: vary
; Parameters...: null
; Modifiers....: all registers
; Returns......: null
; Description..: prints the command line arguments
; ----------------------------------------------------------


section .data
    ; system calls
    sys_exit        equ     1
    sys_write       equ     4

    ; std pipes
    stdout          equ     1

    ; status code
    exit_normal     equ     0


section .bss

section .text

    extern strlen

    global _start

_start:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    lea esi, [ebp + 4]          ; skip argc

.loop:
    add esi, 4                  ; next argument 
    mov ecx, [esi]              ; dereference pointer to ecx

    cmp ecx, 0                  ; compare pointer if it is zero it means you hit the last argument
    je exit                     ; if you hit the last argument jum to zero

    push ecx                    ; push argv to stack as 'strlen' first argument
    call strlen                 ; call strlen procedure
    mov edx, eax                ; strlen result is in eax, move it to edx as print count
    lea esp, [esp + 4]          ; pop the argument from stack

    call print                  ; print the argument
    call print_newline          ; print a newline char

    jmp _start.loop             ; continue

print:
    ; std sys_write
    mov eax, sys_write
    mov ebx, stdout
    ; ecx is already holding the pointer of argument
    ; edx is already holding the print count
    int 80h
    ret

print_newline:
    push 10                     ; push newline char to stack so esp will point that char
    ; std sys_write
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, esp                ; esp is the pointer of char '10'
    mov edx, 1                  ; print 1 char
    int 80h
    ; restore esp by popping newline char. eax is not in use so we can pop in to it. 
    pop eax
    ret

exit:
    ; std epilogue
    mov esp, ebp
    pop ebp
    
    ; std sys_exit
    mov eax, sys_exit
    mov ebx, exit_normal
    int 80h
