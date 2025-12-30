; Q10 - File Handling Program

newLine macro
  mov dl,13
  mov ah,02h
  int 21h
  mov dl,10
  mov ah,02h
  int 21h
endm

printStr macro msg
  mov dx, offset msg
  mov ah,09h
  int 21h
endm

.model small
.stack 100h

.data
fileName      db "nida.txt",0
fileMadeMsg   db "FILE CREATED SUCCESSFULLY.$"
dataMovedMsg  db "DATA MOVED SUCCESSFULLY.$"
fileClosedMsg db "FILE CLOSED.$"
fileErrorMsg  db "FILE OPERATION FAILED.$"
nameData      db "Nida Irshad"
fileHandle    dw ?

.code
main proc
    mov ax,@data
    mov ds,ax

; -------- CREATE FILE --------
    mov ah,3Ch
    mov cx,0
    mov dx,offset fileName
    int 21h
    jc fileError

    mov fileHandle,ax       ; ? STORE HANDLE HERE
    printStr fileMadeMsg
    newLine

; -------- WRITE FILE --------
    mov ah,40h
    mov bx,fileHandle       ; ? USE HANDLE
    mov dx,offset nameData
    mov cx,11
    int 21h
    jc fileError

    printStr dataMovedMsg
    newLine

; -------- CLOSE FILE --------
    mov ah,3Eh
    mov bx,fileHandle
    int 21h

    printStr fileClosedMsg
    newLine
    jmp exitProgram

fileError:
    printStr fileErrorMsg

exitProgram:
    mov ah,4Ch
    int 21h
main endp
end main
