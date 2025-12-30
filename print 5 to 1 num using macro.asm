 newLine macro
    mov dl,013d
    mov ah,02h
    int 21h
    
    mov dl,010d
    mov ah,02h
    int 21h
endm


printNum macro 
   local loop1  
   loop1:
    
    mov dx,cx
    add dx,048d
    mov ah,02h
    int 21h
    newLine
    loop loop1 
    
endm

.model small
.stack 100h
.data

.code
main proc
    
    mov ax,@data
    mov ds,ax
    
    mov cx,5
    printNum
    
    mov ah,4ch
    int 21h
    
    main endp
end main

;
