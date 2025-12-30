;single digit + or - by user input and display result

.model small
.stack 100h
.data  

startStatement db "press + for addition or - for subtraction or esc to exit :$"
num1 db "Enter number 1 : $" 
num2 db "Enter number 2: $"
result_Str db "result : $"
nl db 010,013,"$"

.code

main proc  
    
   
    mov ax,@data
    mov ds,ax
    
     main_:
    mov dl,offset startStatement
    mov ah,09h                  
    int 21h 
    
    mov dl,offset nl
    mov ah,09h
    int 21h
    
    mov ah,01h ;user gives input here
    int 21h 
            
    mov bl,al ;as al value would change when nl 
    ;nl 
    mov dl,offset nl
    mov ah,09h
    int 21h
    
    cmp bl,'+'
    je add_op
    
    cmp bl,'-'
    je sub_op 
    
    cmp bl,1bh
    je exit_op
    
    add_op:
    ;num1
    mov dl , offset num1
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    
    sub al,30h ;convert to number from ascii code
    
    ;num1
    mov bl,al
    
    ;nl
     mov dl,offset nl
    mov ah,09h
    int 21h
    
    ;num2
    mov dl , offset num2
    mov ah,09h
    int 21h 
    
    mov ah,01h
    int 21h
    sub al,30h ;convert to number from ascii code
    
    add al,bl
    
    ;convert back to ascii code
    add al,30h
    mov dl,al
   
    mov ah,02h
    int 21h
    jmp main_
    
    sub_op:
    ;num1
    mov dl , offset num1
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    
    sub al,30h ;convert to number from ascii code
    
    ;num1
    mov bl,al
    
    ;nl
     mov dl,offset nl
    mov ah,09h
    int 21h
    
    ;num2
    mov dl , offset num2
    mov ah,09h
    int 21h 
    
    mov ah,01h
    int 21h
    sub al,30h ;convert to number from ascii code 
    
    
    sub bl,al ;only this line changes same as for add 
    
     ;convert back to ascii code
    add al,30h
    mov dl,al
    
    mov ah,02h
    int 21h
    jmp main_
    
    
    exit_op:
    mov ah,4ch
    int 21h
    
    main endp
end main