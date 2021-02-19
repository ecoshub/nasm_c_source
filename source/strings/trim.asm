; ----------------------------------------------------------
; Name.........: trim_space
; Author.......: eco
; Date.........: 19.02.2021
; Arguments....: null
; Parameters...: string pointer via stack
; Modifiers....: all registers
; Returns......: null
; Description..: trim left and right spaces of string that passed with stack
; ----------------------------------------------------------

; ----------------------------------------------------------
; Name.........: trim_left
; Author.......: eco
; Date.........: 19.02.2021
; Arguments....: null
; Parameters...: string pointer via stack
; Modifiers....: all registers
; Returns......: null
; Description..: trim left spaces of string that passed with stack
; ----------------------------------------------------------

; ----------------------------------------------------------
; Name.........: trim_right
; Author.......: eco
; Date.........: 19.02.2021
; Arguments....: null
; Parameters...: string pointer via stack
; Modifiers....: all registers
; Returns......: null
; Description..: trim right spaces of string that passed with stack
; ----------------------------------------------------------


section .data
section .bss
section .text
    extern strlen
    global trim_left_space
    global trim_right_space
    global trim_space

; reads the string pointer from stack and stores it in 'esi'
; finds strings length and stores it in 'edi'
; empty string control
; single char control
; single space control
prepare:
    mov esi, [ebp + 8]              ; read string pointer in to esi from stack
                                    ; from this on esi is representing the 'string' pointer

    ; get length of string
    push esi                        ; push strings pointer to stack
    call strlen                     ; call strlen function
    lea esp, [esp + 4]              ; pop the argument from stack
                                    ; length of the string is in eax now

    mov edi, eax                    ; store length to use later
                                    ; from this on edi is representing the string length
    
    cmp eax, 0                      ; compare length, 0
    je done                         ; if length == 0; jump exit

    cmp eax, 1                      ; compare length, 1
    je control_single_char          ; if length == 1; jump control_single 
    ret                             ; return from prepare

; trims all spaces in left and right of the string
trim_space:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    call prepare                    ; read stack, get length and control one and none char
    
    call left_core                  ; start left trim core procedure
    
    mov edi, edx                    ; edx is holding the current string length so lets restore edi with it
    
    call right_core                 ; start right trim core procedure

    ; std epilogue
    mov esp, ebp
    pop ebp
    ret


trim_right_space:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    call prepare                    ; read stack, get length and control one and none char
    
    call right_core                 ; start right trim core procedure

    ; std epilogue
    mov esp, ebp
    pop ebp
    ret


trim_left_space:

    nop
    push ebp
    mov ebp, esp
    ; std prologue

    call prepare                    ; read stack, get length and control one and none char
    
    call left_core                  ; start left trim core procedure

    ; std epilogue
    mov esp, ebp
    pop ebp
    ret



right_core:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    mov eax, edi                    ; pass length to eax
    dec eax                         ; get length-1 (last index)

    jmp right_core.condition

.loop:
    dec eax                         ; decrement index to find previous char

.condition:
    cmp byte [esi+eax], 20h         ; check string[i] is space char (' ')
    je right_core.loop              ; if it is space keep going

    cmp eax , 0                     ; check if backward search is in first index
    jb empty_string                 ; if backward search index is zero this means it is an empty string (full of spaces) jump to it.
    
    inc eax                         ; increment index to switch from non-space char to first space after that         
    mov byte [esi+eax], 0           ; put a null char to mark its end

    ; std epilogue
    mov esp, ebp
    pop ebp
    ret

left_core:
    nop
    push ebp
    mov ebp, esp
    ; std prologue

    ; left space search
    xor ecx,ecx                     ; ecx is going to first non-space char index
                                    ; lets clear it

    jmp left_core.condition         ; start with comparison

; this loop start with index zero and increments itself until it hits a non-space char
.loop_left:
    inc ecx                         ; point to next char

.condition:
    cmp byte [esi+ecx], 20h         ; compare string[i], ' '
    je left_core.loop_left          ; if string[i] == ' ' jump  loop_left

    cmp ecx, edi                    ; compare first non-space char index with string length
    jae empty_string                ; if first non-space char index is bigger or equal to length
                                    ; it means this string is only containing spaces
                                    ; send an empty string ("")

    xor edx, edx                    ; clear edx value
                                    ; we are gonna use it like a counter.

    jmp left_core.insert_condition

.insert:
    mov bl, byte [esi+ecx]          ; move non-space char to register
    mov byte [esi+edx], bl          ; move non-space char from register to left side of the string ( shifting )
    inc edx                         ; increment shifted index
    inc ecx                         ; increment original index
.insert_condition:
    cmp ecx, edi                    ; compare first and last index
    jne left_core.insert            ; if current index is below or equal to last index, repeat

    ; insert end
    mov byte[esi+edx], 0            ; add null-terminator to end

    ; std epilogue
    mov esp, ebp
    pop ebp
    ret

control_single_char:
    cmp byte [esi], 20h             ; compare only char with space char
    je empty_string                 ; if only char is space return a empty string
    jmp done                        ; done from program

empty_string:
    mov byte[esi], 0                ; add null-terminator to end
    jmp done                        ; done from program

done:
    ; std epilogue
    mov esp, ebp
    pop ebp
    ret
