.MODEL SMALL
.STACK 100h
.DATA

num db 5 dup(?)           ; buffer for digits
str db "Enter a number: $"
newline db 0Dh,0Ah,"$"

.CODE

main PROC
    mov ax, @data
    mov ds, ax

    ; Display prompt
    mov dx, offset str
    mov ah, 09h
    int 21h

    ;-------------------------------------
    ; READ NUMBER
    ;-------------------------------------
    mov bx, offset num     ; pointer to array

read_loop:
    mov ah, 01h            ; read char
    int 21h

    cmp al, 0Dh            ; Enter pressed?
    je print_number

    ; validate digit
    cmp al, '0'
    jl read_loop
    cmp al, '9'
    jg read_loop

    mov [bx], al           ; store digit
    inc bx                 ; move to next
    jmp read_loop

    ;-------------------------------------
    ; PRINT STORED NUMBER
    ;-------------------------------------
print_number:
    mov dx, offset newline
    mov ah, 09h
    int 21h

    mov bx, offset num     ; reset pointer

print_loop:
    mov al, [bx]
    cmp al, 0              ; empty cell?
    je exit_program        ; stop

    mov dl, al             ; print ASCII digit
    mov ah, 02h
    int 21h

    inc bx
    jmp print_loop

exit_program:
    mov ah, 4Ch
    int 21h
main ENDP
END main
