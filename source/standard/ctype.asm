; ----------------------------------------------------------
; Name.........: ctype
; Author.......: eco
; Date.........: 18.03.2021
; Arguments....: null
; Parameters...: one byte with stack
; Modifiers....: all
; Returns......: eax (bool 0 or 1)
; Description..: recreation of ctype.h
;                procedures:
;                - isspace
;                - iscntrl
;                - isprint
;                - isgraph
;                - isblank
;                - islower
;                - isupper
;                - isalnum
;                - isalpha
; ----------------------------------------------------------

section .data
section .bss
section .text
    global isspace
    global iscntrl
    global isprint
    global isgraph
    global isblank
    global islower
    global isupper
    global isalnum
    global isalpha
    global isdigit

isalnum:
    mov ecx, .end               ; push end point of this function (link pointer)
    
    call isalpha                ; call inner function
    cmp eax, 1                  ; compare result of recent call
    je true                     ; write true to eax

    call isdigit                ; call inner function
    cmp eax, 1                  ; compare result of recent call
    je true                     ; write true to eax

    jmp false                   ; write false to eax
.end:
    ret

isalpha:
    mov ecx, .end               ; push end point of this function (link pointer)
    
    call isupper                ; call inner function
    cmp eax, 1                  ; compare result of recent call
    je true                     ; write true to eax

    
    call islower                ; call inner function
    cmp eax, 1                  ; compare result of recent call
    je true                     ; write true to eax

    jmp false                   ; write false to eax
.end:
    ret

isdigit:
    mov ecx, .end               ; push end point of this function (link pointer)
    
    cmp ebx, '0'
    jb false

    cmp ebx, '9'
    ja false
    
    jmp true
.end:
    ret

isupper:
    mov ecx, .end               ; push end point of this function (link pointer)

    cmp ebx, 'A'
    jb false

    cmp ebx, 'Z'
    ja false

    jmp true
.end:
    ret

islower:
    mov ecx, .end               ; push end point of this function (link pointer)
    
    cmp ebx, 'a'
    jb false

    cmp ebx, 'z'
    ja false
    
    jmp true
.end:
    ret

isspace:
    mov ecx, .end               ; push end point of this function (link pointer)
    cmp ebx, 0x20               ; space char
    je true                     ; write true to eax
    cmp ebx, 0x9                ; horizontal TAB char
    je true                     ; write true to eax
    cmp ebx, 0xA                ; newline char
    je true                     ; write true to eax
    cmp ebx, 0xB                ; vertical TAB char
    je true                     ; write true to eax
    cmp ebx, 0xC                ; from feed, next page char
    je true                     ; write true to eax
    cmp ebx, 0xD                ; carriage RET char
    je true                     ; write true to eax
.end:
    ret

isprint:
    mov ecx, .end               ; push end point of this function (link pointer)
    call iscntrl                ; call inner function
    cmp eax, 0                  ; compare result of recent call
    je true                     ; write true to eax

    jmp false                   ; write false to eax
.end:
    ret


iscntrl:
    mov ecx, .end               ; push end point of this function (link pointer)
    cmp al, 0x20                ; all control chars above 0x20 (32 dec)
    jb true
    
    cmp al, 0x7F                ; 0x7F is DEL char and and DEL char is a control char
    je true                     ; write true to eax
    
    jmp false                   ; write false to eax
.end:
    ret

isgraph:
    mov ecx, .end               ; push end point of this function (link pointer)

    call iscntrl                ; call inner function
    cmp eax, 0                  ; compare result of recent call
    je false

    cmp ebx, 0x20
    je false

    jmp true
.end:
    ret

isblank:
    mov ecx, .end               ; push end point of this function (link pointer)

    cmp ebx, 0x20               ; space char
    je true                     ; write true to eax

    cmp ebx, 0x9                ; horizontal TAB char
    je true                     ; write true to eax

    jmp false                   ; write false to eax
.end:
    ret

false:
    mov eax, 0
    jmp ecx

true:
    mov eax, 1
    jmp ecx
