.model small                             
.stack 100h
.data

nl db 010d,013d,'$'
.code
      
      ;print odd num from 5 to 9
main proc
    
    mov ax,@data
    mov ds,ax
    
    
    mov cx,4
    mov bl,'3'
    
    print_Loop: 
    mov dl,bl
    mov ah,02h
    int 21h
    mov bl,dl
    
    mov dl,offset nl
    mov ah,09h
    int 21h
    
    add bl,2
    loop print_Loop
    
    mov ah,4ch
    int 21h
    
    main endp
end main