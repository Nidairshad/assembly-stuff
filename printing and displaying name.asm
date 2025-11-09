;print and display your full name

.model small
.stack 100h
.data

str db 'Nida Irshad$'

.code

main proc             
    
    mov ax,@data
    mov ds,ax
    mov ah,9h
    mov dx,offset str
    
    int 21h
    
    mov ah,4ch
    int 21h
    
    main endp
end main



