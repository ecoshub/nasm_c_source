; <working progress>
; ----------------------------------------------------------
; Name.........: printf
; Author.......: eco
; Date.........: 07.03.2021
; Arguments....: null
; Parameters...: values to print and string to format
; Modifiers....: all registers
; Returns......: null
; Description..: standard printf function in clang
; ----------------------------------------------------------

; ----------------------------------------------------------
; Defined formats:
; '%s'...........: print string (string pointer, char *)
; '%d'...........: print integer
; '%i'...........: print integer
; '%u'...........: print unsigned integer
; '%x'...........: print hexadecimal value in lower format
; '%X'...........: print hexadecimal value in upper format
; ----------------------------------------------------------

; ----------------------------------------------------------
; Notes:
; - escape characters
; - %% symbol
; - next (%o %c)
; ----------------------------------------------------------

section .data
    ; constants
    hex_list_upper              db      "0123456789ABCDEF"
    hex_list_lower              db      "0123456789abcdef"
    number_list                 db      "0123456789"

    ; errors
    error_identifier_expected   db      "unknown format identifier after '%'.", 0
    error_ie_length             equ     $-error_identifier_expected

section .bss
    _list                       resd    1
    
section .text
    extern strlen
    global printf

printf:
    nop
    push ebp
    mov ebp, esp
    ; std prologue


    mov edi, [ebp + 8]                  ; reading string from stack and store it in edi
                                        ; this is te string to format

    push edi                            ; push string pointer to stack again to get strlen
    call strlen                         ; call strlen
    lea esp, [esp + 4]                  ; restore esp

    mov edx, eax                        ; load strlen to edx

    xor edi, edi                        ; clear edi, edi is keeping argument index
    xor ecx, ecx                        ; string index counter

.loop:
    mov eax, [ebp + 8]                  ; [ebp + 8] is pointing to main string of printf
    add eax, ecx                        ; add index count to string pointer
    mov eax, [eax]                      ; dereference it to get char

    cmp ecx, edx                        ; compare index to string length
    je done                             ; if equal jump to done
    cmp al, '%'                         ; compare input[i] to '%' symbol
    je print_symbol_found               ; if it is '%' than jump to print_symbol_found
    call print_char
back_from_print:
    inc ecx                             ; increment ecx (i, string index)
    jmp printf.loop                     ; keep going...

print_symbol_found:
    inc ecx                             ; increment esi to get element after '%'

    mov ebx, [ebp + 8]                  ; [ebp + 8] is pointing to main string of printf
    add ebx, ecx                        ; add index count to string pointer
    mov ebx, [ebx]                      ; dereference it to get char


    cmp bl, 's'                         ; compare char to 's' (string)
    je call_string                      ; if it is 's' then jump to print_string procedure
    cmp bl, 'u'                         ; compare char to 'u' (unsigned integer)
    je call_print_uint                  ; if it is 'u' then jump to call_print_uint procedure
    cmp bl, 'd'                         ; compare char to 'd' (integer)
    je call_print_int                   ; if it is 'd' then jump to call_print_uint procedure
    cmp bl, 'i'                         ; compare char to 'i' (integer)
    je call_print_int                   ; if it is 'i' then jump to call_print_int procedure
    cmp bl, 'x'                         ; compare char to 'x' (hex lower)
    je call_print_hex_lower             ; if it is 'x' then jump to call_print_hex_lower procedure
    cmp bl, 'X'                         ; compare char to 'X' (hex upper)
    je call_print_hex_upper             ; if it is 'X' then jump to call_print_hex_upper procedure
    mov ecx, error_identifier_expected  ; load the error pointer
    mov edx, error_ie_length            ; load error length to edx
    call print_preloaded                ; call preloaded print procedure to print error
    jmp done                            ; jump to done

call_string:
    lea eax, [ebp + 12 + 4 * edi]       ; [ebp + 12] is the first argument, add argument count to find corresponding argument.
    mov eax, [eax]                      ; dereference address in eax in to ecx
    push eax                            ; push the string pointer to stack
    call print_string                   ; call string print procedure
    lea esp, [esp + 4]                  ; restore stack pointer
    inc edi                             ; increment argument counter
    jmp back_from_print

call_print_uint:
    lea eax, [ebp + 12 + 4 * edi]       ; [ebp + 12] is the first argument, add argument count to find corresponding argument.
    mov eax, [eax]                      ; dereference address in eax in to ecx
    mov eax, [eax]                      ; dereference address in eax in to eax

    ; select list to print from
    mov ebx, dword number_list
    mov dword [_list], ebx
    mov ebx, 10

    call print_uint                     ; call integer print procedure
    inc edi                             ; increment argument counter
    jmp back_from_print                 ; jump back

call_print_int:
    lea eax, [ebp + 12 + 4 * edi]       ; [ebp + 12] is the first argument, add argument count to find corresponding argument.
    mov eax, [eax]                      ; dereference address in eax in to ecx
    mov eax, [eax]                      ; dereference address in eax in to eax

    ; select list to print from
    mov ebx, dword number_list
    mov dword [_list], ebx
    mov ebx, 10

    call print_int                      ; call integer print procedure
    inc edi                             ; increment argument counter
    jmp back_from_print                 ; jump back

call_print_hex_lower:
    lea eax, [ebp + 12 + 4 * edi]       ; [ebp + 12] is the first argument, add argument count to find corresponding argument.
    mov eax, [eax]                      ; dereference address in eax in to ecx
    mov eax, [eax]                      ; dereference address in eax in to eax

    ; select list to print from
    mov ebx, dword hex_list_lower
    mov dword [_list], ebx
    mov ebx, 16                         ; set the base

    call print_uint                     ; call integer print procedure
    inc edi                             ; increment argument counter
    jmp back_from_print                 ; jump back

call_print_hex_upper:
    lea eax, [ebp + 12 + 4 * edi]       ; [ebp + 12] is the first argument, add argument count to find corresponding argument.
    mov eax, [eax]                      ; dereference address in eax in to ecx
    mov eax, [eax]                      ; dereference address in eax in to eax

    ; select list to print from
    mov ebx, dword hex_list_upper
    mov dword [_list], ebx    
    mov ebx, 16                         ; set the base

    call print_uint                     ; call integer print procedure
    inc edi                             ; increment argument counter
    jmp back_from_print                 ; jump back


print_string:
    pushad                              ; store all registers

    push eax                            ; push pointer to stack
    call strlen                         ; call the strlen procedure
    lea esp, [esp + 4]                  ; restore stack pointer
    mov edx, eax                        ; move string length to edx

    call print_preloaded                ; call preloaded print

    popad                               ; restore all registers
    ret                                 ; return

print_uint:
    pushad                              ; store all registers
    xor ecx, ecx                        ; clear ecx, ecx is now stack counter

.bcd_loop:                              ; convert integer value to bcd
    xor edx, edx                        ; clear edx. it will contain reminder
    div ebx                             ; divide exa to ebx
    push edx                            ; push reminder to stack
    inc ecx                             ; increment stack counter
    cmp eax, 0                          ; compare reminder to zero
    jnz print_uint.bcd_loop             ; jump to divide routine if reminder is not zero
    jmp print_uint.cmp_done             ; jump to comparison part

.print_loop:

    pop eax                             ; pop reminder from stack
    push ebx                            ; store ebx
    mov ebx, dword [_list]              ; dereference list address, now ebx hold the pointer of string list ( _list)
    mov eax, [ebx+eax]                  ; add number to _list address it will convert integer value to string value
    pop ebx                             ; restore ebx
    call print_char                     ; print the char in eax

.cmp_done:
    cmp ecx, 0                          ; compare stack count to zero
    je print_uint.done                  ; if its zero that no more number to print jump done
    dec ecx                             ; if its not zero decrement
    jmp print_uint.print_loop           ; keep going

.done:
    popad                               ; restore all registers
    ret                                 ; return

print_int:
    bt eax, 31                          ; test the sign bit
    jc print_int.print_negative         ; if signed number then jump to negative print
    call print_uint                     ; if its not a signed number print like uint
.end:
    ret                                 ; return

.print_negative:
    neg eax                             ; negate the number 
    pushad                              ; store all registers

    mov al, '-'                         ; load '-' symbol to al
    push eax                            ; push eax to stack so esp points it
    mov edx, 1                          ; symbol length is 1 
    mov ecx, esp                        ; load the symbol pointer to ecx to print
    call print_preloaded                ; print the minus symbol
    lea esp, [esp + 4]                  ; restore esp

    popad                               ; restore all registers
    mov ebx, 10
    call print_uint                     ; print eax like a uint number
    jmp print_int.end                   ; jump to print end

print_char:
    pushad                              ; store all registers
    push eax                            ; push the value to print to stack, esp is going to point it
    mov ecx, esp
    mov edx, 1

    call print_preloaded

    ; restore stack pointer
    lea esp, [esp + 4]
    popad                               ; restore all registers
    ret                                 ; return

print_preloaded:
    ; std print operation
    ; ecx and edx must pre loaded
    mov eax, 4
    mov ebx, 1
    int 0x80
    ret


done:
    ; std epilogue
    mov esp, ebp
    pop ebp
    nop

    mov eax, 1
    mov ebx, 0
    int 0x80

