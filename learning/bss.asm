; pre definition section
; loading ram before execution. it works like reprocesses
section .bss

    ; [bit_size table]
    ; byte          b   (1 byte)
    ; word          w   (2 bytes)
    ; doubleword    d   (4 byte)
    ; quadword      q   (8 bytes)
    ; tenbytes      t   (10 bytes)

    ; DEFINE
    ; d[bit_size]
    ; [label] [bit_size] [initial_data]

    age db 10         ; define a byte and initialize it with 10

    ; times for array declaration
    arr times 100 db 0  ; define 100 bytes and init all by 0 

    ; string declaration. double quote can be use as well
    name db 'e', 'c', 'o', 0
    name db 'eco', 0

    ; hex declaration 
    ; * must start with zero
    year dw 07E5h
    ; other bases
    ; binary
    month db 10b
    ; octal
    day db 6o

    ; define without initialize
    name db ?

    ; define array
    arr db 64 dup (?)       ; define 64 bytes of data and not initialize.


    ; RESERVE
    ; res[bit_size]
    ; [label] [bit_size] [data_length]

    placeholder resb 100    ; reserve 100 bytes of memory

    int_array resd 100      ; reserver 100 x 4 bytes of memory

section .text

    ; size specifiers
    ; byte      (1 byte)
    ; word      (2 bytes)
    ; dword     (4 bytes)
    ; qword     (8 bytes)
    ; tword     (10 bytes)

_start:
    mov eax, dword [int_array]  ; move int_array's first doubleword (4 bytes) in to eax 


