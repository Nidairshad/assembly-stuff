;adding multi digit

;to do:program to take user input of multidigit number and then add in given
;number 4567 for example

.model small
.stack 100h
.data

currNum db 6 dup(?)
.code

main proc
    
    mov ax,@data
    mov ds,ax
   
    mov ax,123

    mov bx,456
    mov cx,0
   
    ;add val ditectly
    add ax,bx
    
    extractDigit:
    mov dx,0
    mov bx,10 ;setting to 10 ax/bx ->ax/10 ->remainder in dx quotient in ax 
    ;123/10 gives 3 remainder which would be at unit place and so on
    div bx ;remainder in dx
    
    push dx ;push to stack
    inc cx
   
    cmp ax,0 ;if ax is not zero means there is still a number continue the loop
    jne extractDigit
    
    printNum:
    
    cmp cx,0 ;no digit to display
    je exit
    
    dec cx
    pop dx
    
    add dx,48 ;conver to ascii char
    mov ah,02h ;display
    int 21h
    jmp PrintNum  


    exit:
    mov ah,4ch
    int 21h
    
    main endp
   

 
end main