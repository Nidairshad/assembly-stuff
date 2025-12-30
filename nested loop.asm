;nested loop

.model small
.stack 100h
.data 

star db 1 
nl db 010d,013d,'$'

.code

main proc
    
    mov ax,@data
    mov ds,ax
    
    mov cx,5
    outerLoop: 
    
    mov bx,cx 
    mov cl,star ;cl =  1
    
    innerLoop:
    mov dl,'*'
    mov ah,02h
    int 21h
    loop innerLoop
    
    inc star
    mov dx,offset nl
    mov ah,09h
    int 21h
    mov cx,bx
    loop outerLoop
    
    
    mov ah,4ch
    int 21h
    
    main endp
end main