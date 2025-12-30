;;9. Write a program to take
; your full name as string input
;  until the ENTER key is pressed,
;then display the string output in newline.

newLine macro
  mov dl,013d
  mov ah,02h
  int 21h
  
  mov dl,010d
  mov ah,02h
  int 21h 
endm

printStr macro msg
    mov dx,offset msg
    mov ah,09h
    int 21h
endm

.model small
.stack 100h
.data

msgInput db "ENTER YOUR NAME:$"
msgOutput db "YOUR NAME:$"
userNameInput db 11 dup (?) 

.code 

main proc
    
    mov ax,@data
    mov ds,ax
    
    printStr msgInput
    
    mov bx,offset userNameInput 
    
    mov cx,0
    
    takeInput:
    mov ah,01h
    int 21h 
    cmp al,0dh
    je printMsg
    mov [bx],al 
    inc bx
    inc cx
    jmp takeInput
    
    printMsg:
    newLine
    printStr msgOutput
    ;reinitliazie from 0th index
    mov bx,offset userNameInput
     
     
    printNameLoop:
     
     mov dl,[bx]
     mov ah,02h
     int 21h
     inc bx
     loop printNameLoop
    
    exit:
    mov ah,4ch
    int 21h
    
    main endp
end main