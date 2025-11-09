;calulcator

.model small
.stack 100h
.data
str1 db "Enter option + - * /: or press e key to exit$" 
nl db 010,013, "$"
num1 db "Enter number 1 : $"
num2 db "Enter number 2 : $" 
note_for_div db "Enter divisor first then dividend eg: 3 ,9 gives -> 9/3$"
result db "Your result : $"

.code

main proc
    mov ax,@data
    mov ds,ax 
   
                      
start:

    mov dx,offset str1
    mov ah,09h
    int 21h

    call displaynl
    
    mov ah,01h ;charcater input
    int 21h 
    
    mov bl,al ;store the character in bl 
    
    call displaynl
   
     ;compare the char value  
    
    cmp bl,'+' ;+
    je add_op 
    
    cmp bl,'-' ;-
    je sub_op
    
    cmp bl,'*'   ;*
    je mul_op
    
    cmp bl,'/'     ;/  
    je div_op 
    
    cmp bl,'e'
    je exit_         
   
    
    add_op: ;add label
    
    call printStatement
    
    add al,bl 
    mov bl,al

    ;output 
    
    call displaynl
   
    mov dx, offset result
    mov ah, 09h
    int 21h 
           
    call displaynl  
    
    add bl,30h
    mov dl,bl
    mov ah,02h 
    int 21h 
    
    call displaynl
    jmp start 
    
    ;subtract label
    sub_op:
    call printStatement
    
    sub al,bl
    mov bl,al
    
    call displaynl
    
    mov dx, offset result
    mov ah, 09h
    int 21h 
    
    call displaynl 
    
    add bl,30h
    mov dl,bl
    mov ah,02h 
    int 21h
    
    call displaynl 
    
    jmp start
    
    ;multiply label
    
    mul_op:
    call printStatement
    
    mul bl
    mov bl,al
    
    call displaynl
       
    mov dx, offset result
    mov ah, 09h
    int 21h 
    
    call displaynl
    add bl,30h
    mov dl,bl
    mov ah,02h 
    int 21h 
    
    call displaynl
    jmp start
    
    ;divide label 
    div_op:  
    ;note for divison
    
    mov dx,offset note_for_div
    mov ah,09h
    int 21h
    
    call displaynl
    call printStatement
    
    mov ah,0
    div bl
    mov bl,al
    
    call displaynl
       
    mov dx, offset result
    mov ah, 09h
    int 21h 
    
    call displaynl
    add bl,30h  ;
    mov dl,bl  
    
    mov ah,02h 
    int 21h 
    call displaynl

    
    jmp start
    ;exit label
    exit_:
    mov ah,4ch
    int 21h
    
    main endp
    
    ; printing statement procedure
    printStatement proc 
                           
    mov dx,offset num1
    mov ah,09h
    int 21h 
    
    mov ah,01h    ;input num1
    int 21h
    sub al,30h
    
    mov bl,al ;store num1 in base register     
    
    call displaynl
    
   
    mov dx,offset num2
    mov ah,09h
    int 21h
 
          
    mov ah,01h ;input num2
    int 21h
    sub al,30h 
    
    ret
    printStatement endp 
    
    ;display newline proc
    displaynl proc
     
        mov dx, offset nl
        mov ah, 09h
        int 21h  
        ret
        displaynl endp
        
end main
             
             ;from subtraction multiplication division
    
    