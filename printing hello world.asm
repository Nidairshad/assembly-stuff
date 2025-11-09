;display hello world

.model small
.stack 100h
.data

   str db 'Hello World$' 
   
.code


main proc
    mov ax,@data
    mov ds,ax
    
    mov dx,offset str
    mov ah,09h
    int 21h
    
    mov ah,4ch
    int 21h
    
    
    main endp
end main