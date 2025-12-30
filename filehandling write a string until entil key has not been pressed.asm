;Practice question ->FILE HANDLING
newLine macro

mov dl,010d
mov ah,02h
int 21h

mov dl,013d
mov ah,02h
int 21h

endm

printStr macro msg
    lea dx,msg
    mov ah,09h
    int 21h
endm
     
     
.model small
.stack 100h
.data

fileName db 'scores.txt',0
fileHandle dw ?
fileCreated db "FILE CREATED SUCESSFULLY$"
userName db 5 dup(?)
fileEntered db "USER NAME ENTERED SUCESSFULLY$"
error db "ERROR$"
.code


main proc
    
    mov ax,@data
    mov ds,ax 
    
    createFile:
    mov ah,3Ch
    mov cx,0
    mov dx,offset fileName
    int 21h
    
    jc errorMSG 
    mov fileHandle,ax
    
    jmp openFile
    openFile:
    mov ah,3Dh
    mov al,0
    mov dx,offset fileName
    int 21h
    jc errorMSG
    printStr fileCreated
    
    
    mov bx,offset userName 
    newLine
    jmp TakeInput
    TakeInput:
    mov ah,01h
    int 21h
    cmp al,0Dh 
    je printInput
    inc cx
    mov [bx],al
    inc bx
    jmp TakeInput
    
    printInput:
    mov si,cx
    newLine
    mov bx,offset userName ;reinitlize to 0th index  
    newLine
    printStr fileEntered 
    jmp print_ 
    newLine
    print_:
    mov al,[bx]
    mov dl,al
    mov ah,02h
    int 21h 
    inc bx
    loop print_
    
    ;reintilize to 0 
    mov bx,offset userName
    jmp writeInFile
    writeInFile: 
    mov ah,40h 
    mov bx,fileHandle
    mov cx,si ;restore num of user name character
    
    mov dl,offset userName 
    int 21h
    
    jc errorMSG    
    jmp exit   
    errorMSG:
    printStr error
    
   exit:
   mov ah,3Eh
   mov bx,fileHandle
   int 21h
   jc errorMSG
    mov ah,4ch
    int 21h 
    
    main endp
end main