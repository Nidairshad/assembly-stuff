;===========================================
; Multi-digit input
; Add new value to previous total
; Repeat while user enters 'y'
;===========================================


macro  nl
    
    mov dx,013d
    mov ah,02h
    int 21h
    
    mov dx,010d
    mov ah,02h
    int 21h
    
    nl endm

    
.model small
.stack 100h

.data
total    dw 0          ; stores running total
inputNum dw 0          ; stores user input
msg      db 13,10,"Continue (y/n)? $"

.code
main proc
    mov ax, @data
    mov ds, ax

startMain:
    mov dx, offset msg
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
   
    cmp al, 'y' 
    nl
    jne exit

    call readNum           ; read number ? inputNum

    mov ax, total
    add ax, inputNum
    mov total, ax          ; update total

    call printNum          ; print AX

    jmp startMain

exit:
    mov ah, 4Ch
    int 21h
main endp

;===========================================
; Read multi-digit number from keyboard
;===========================================
readNum proc
    nl
    
    mov inputNum, 0
    mov bx, 10

readLoop:
    mov ah, 01h
    int 21h
    cmp al, 13             ; ENTER
    je done

    sub al, '0'
    mov ah, 0

    mov cx, ax
    mov ax, inputNum
    mul bx
    add ax, cx
    mov inputNum, ax

    jmp readLoop

done:
    ret
readNum endp

;===========================================
; Print number in AX
;===========================================
printNum proc
    push ax          ; preserve AX
    push bx
    push cx
    push dx

    mov bx, 10
    mov cx, 0

extract:
    mov dx, 0
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne extract

display:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop display

    pop dx           ; restore registers
    pop cx
    pop bx
    pop ax
    ret
printNum endp

end main
