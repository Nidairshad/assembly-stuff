.model small
.stack 100h

.data
.code
main proc
    
   
    mov ah, 1h ;1h = read instruction
    int 21h
          
    ;
    mov ah,2h
    int 21h
    
    mov ah ,4ch ;4h terminates the program
    int 21h
    
    
    main endp
end main