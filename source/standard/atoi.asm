; ----------------------------------------------------------
; Name.........: atoi 
; Author.......: eco
; Date.........: 20.02.2021
; Arguments....: null
; Parameters...: string pointer passed with stack
; Modifiers....: all registers
; Returns......: eax
; Description..: converts a string value tu integer value
; ----------------------------------------------------------

section .data
section .bss
    length      resd    1
    multiplier  resd    1 
section .text
    extern strlen
    extern printreg
    global atoi

atoi:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov edi, [ebp + 8]                  ; get string pointer from stack and store it in edi
                                        ; now on edi is string pointer

    ; get string length
    push edi
    call strlen
    add esp, 4

    ; reset ebx it will be the accumulator for this operation 
    xor ebx, ebx

    mov dword [multiplier], 1          ; set multiplier as 1

    ; eax holds the length
    ; if string length is zero then jump to end
    cmp eax, 0
    je end

    ; if string length is 1 then jump to single_char control
    cmp eax, 1
    je single_char

    mov dword [length], eax             ; store eax in to length 

    xor esi, esi                        ; esi will be the index counter of string lets clear it
    xor ebx, ebx                        ; ebx will be the result value
    
    ; sing control
    cmp byte [edi], '-'                 ; compare with '-' char
    je set_negative                     ; if its starting with '-' set multiplier value to -1
    cmp byte [edi], '+'                 ; compare with '+' char
    je skip_first                       ; if its starting with '+' increment the esi

    jmp atoi.condition                  ; start with condition check


.loop:
    xor eax, eax                        ; clear eax
    mov al, byte [edi+esi]              ; store char in to al
    call number_check                   ; check if its a number or not
    sub al, 30h                         ; convert it from ascii to integer

    ; ecx = length - esi - 1
    mov ecx, dword [length]
    sub ecx, esi
    dec ecx
    
    call pow_start                      ; start the power function
    add ebx, eax                        ; add multiped value to result
    inc esi                             ; increment char index


.condition:
    cmp esi, dword [length]             ; compare char index to length
    jne atoi.loop                       ; if its not equal repeat
    jmp end                             ; end

number_check:
    ; check al if it is number
    cmp al, 30h                         ; compare with 30h ('0')
    jb not_valid                        ; if its below '0' then jump to not_valid
    cmp al, 39h                         ; compare with 39h ('9')
    ja not_valid                        ; if its above '9' then jump to not_valid
    ret                                 ; if its valid return


pow_start:
    ; if power index 0 return without change eax
    ; eax = 10^0 * eax
    cmp ecx, 0
    jne pow_condition
    ret

pow:
    mov edx, 10                         ; base is 10
    mul edx                             ; eax *= 10
    ; NOTE control overflow to edx later
    dec ecx                             ; dec power index
pow_condition:
    cmp ecx, 0                          ; compare power index with zero
    jne pow                             ; if it not keep going
    ret

single_char:
    mov al, byte[edi]                   ; read first char in to a
    call number_check                   ; check if it is a number
    sub al, 30h                         ; convert it from ascii to integer
    mov ebx, eax                        ; move to ebx (ebx will be the result)
    jmp end                             ; jump to end

not_valid:
    mov ebx, 0                          ; set the result 0
    jmp end                             ; jump to end

set_negative:
    mov dword [multiplier], -1          ; set multiplier as -1
    jmp skip_first

skip_first:
    inc esi                             ; increment string index to skip current char
    jmp atoi.condition 

end:
    ; std epilogue
    mov esp, ebp
    pop ebp
    nop

    mov eax, ebx
    mul dword [multiplier]
    ret
