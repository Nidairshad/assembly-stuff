;q3

.model small                             
.stack 100h
.data

nl db 010d,013d,'$'
.code
      
      ;print  num from 8 to 2
main proc
    
    mov ax,@data
    mov ds,ax
    
    mov cx,7
    mov bl,'8'
   
    
    printLoop:
    
    mov dl,bl
    mov ah,02h
    int 21h 
    dec bl
 
      
    mov dl,offset nl
    mov ah,09h
    int 21h
    
    loop printLoop
    
    mov ah,4ch
    int 21h
    
    main endp
end main