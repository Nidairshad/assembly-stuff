;procedures

.model small
.stack 100h
.data 

name_ db "Nida$"
str db "about procedures :)$" 

.code

main proc
         mov ax,@data ; declare the data seg
         mov ds,ax 
         
         lea dx,name_
         
         call printStatement 
         call newLine
         
         lea dx, str
         
         call printStatement
         call End_Line
    
    main endp

newLine proc 
    
    mov ah,02h
    mov dl,010d
    int 21h
    
    mov ah,02h
    mov dl,013d
    int 21h
    
    ret
    newLine endp

printStatement proc 
             mov ah,09h
             int 21h   
             
    ret
    printStatement endp  

End_Line proc 
    
    mov ah,4ch
    int 21h
    
    ret
    End_Line endp  
end main