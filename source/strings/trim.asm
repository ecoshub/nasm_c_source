; ----------------------------------------------------------
; Name.........: trim_space
; Author.......: eco
; Date.........: 15.02.2021
; Arguments....: null
; Parameters...: string pointer to trim space
; Modifiers....: all registers
; Returns......: null
; Description..: trims left and right spaces of string
; ----------------------------------------------------------


section .data

section .bss
    string resd 1
    length resd 1

section .text
    extern strlen
    extern printreg
    global trim

trim:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax, [ebp + 8]              ; read parameter from stack
    mov dword [string], eax         ; store parameter (string pointer) in to string variable

    ; get length of string
    push eax                        ; push strings pointer to stack
    call strlen                     ; call strlen function
    lea esp, [esp + 4]              ; pop the argument from stack
                                    ; length of the string is in eax now
    mov [length], eax

    cmp eax, 0                      ; compare length, 0
    je done                         ; if length == 0; jump exit
    cmp eax, 1                      ; compare length, 1
    je control_single               ; if length == 1; jump control_single 


    ; left space search
    xor ecx,ecx                     ; ecx is going to first non-space char index
                                    ; lets clear it
    mov esi, [string]               ; dereference string to find first char
                                    ; from this on esi is representing the 'string' pointer

    jmp trim.comparison_left        ; start with comparison

; this loop start with index zero and increments itself until it hits a non-space char
.loop_left:
    inc ecx                         ; point to next char

.comparison_left:
    cmp byte [esi+ecx], 20h      ; compare string[i], ' '
    je trim.loop_left             ; if string[i] == ' ' jump  loop_left

.done_left:
    dec eax                         ; decrement eax (length) by one to find last index
                                    ; eax is now last index

    cmp ecx, [length]               ; compare first non-space char index with string length
    jae empty_string                ; if first non-space char index is bigger or equal to length
                                    ; it means this string is only containing spaces
                                    ; send an empty string ("")

    jmp trim.comparison_right     ; start with comparison

; this loop starts with last index and decrement itself until it hits the ecx (first non-space char)
.loop_right:
    dec eax                         ; go to start by one char

.comparison_right:
    cmp eax, ecx                    ; compare current index with first non-space char index
    jbe trim.right_done           ; if current chars index below of equal to first non-space char jump to done
    cmp byte [esi+eax], 20h      ; compare current char with space
    je trim.loop_right            ; if current char is space repeat

.right_done:
    jmp trim.comparison_insert    ; start with comparison


; this operation basically shifts the string left
; the amount is ecx (left spaces count)
; and adds a null-terminator after last non-space char. 
.insert:
    mov bl, byte [esi+ecx]          ; move non-space char to register
    mov byte [esi+edx], bl          ; move non-space char from register to left side of the string ( shifting )
    inc edx                         ; increment shifted index
    inc ecx                         ; increment original index
.comparison_insert:
    cmp ecx, eax                    ; compare first and last index
    jbe trim.insert                 ; if current index is below or equal to last index, repeat

    ; insert end
    mov byte[esi+edx], 0            ; add null-terminator to end
    jmp done                        ; done from program


control_single:
    cmp byte [string], 20h          ; compare only char with space char
    je empty_string                 ; if only char is space return a empty string
    jmp done                        ; done from program

empty_string:
    mov byte [string], 0
    jmp done                        ; done from program

done:
    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
