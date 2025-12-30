.model small
.stack 100h
.data
msg db 13,10,"Enter a value to add: $"

.code
main proc
    mov ax,@data
    mov ds,ax

    mov cl,0          ; previous total (NUMBER)

loopNum:
    mov dx,offset msg
    mov ah,09h
    int 21h

    mov ah,01h        ; read char
    int 21h

    sub al,30h        ; ASCII ? number
    add cl,al         ; add to previous total

    mov al,cl
    add al,30h        ; number ? ASCII

    mov dl,al
    mov ah,02h
    int 21h

    jmp loopNum

main endp
end main
