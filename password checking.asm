.model small
.stack 100h
.data

password db '1234'
len equ ($-password) ; current address($) - starting address of password
;equ is a assembler directive ->defines constant 
;.code .data etc these are example of directives  
;equ used to automatcially cal size rather than mov cx,4 it would be hard coded
;$=address after last defined byte
;password = starting address
;subtract -> number of bytes = string length  

msg1 db 10,13,'Enter your password: $'
msg2 db 10,13,'Correct Password,Welcome!!$'
msg3 db 10,13,'Incorrect Password, Please try again!$'
new db 10,13,'$'
inst db 10 dup(0)

.code
                        
start:
mov ax,@data
mov ds,ax
lea dx,msg1
mov ah,09h
int 21h
mov si,00

up1: ;loop that read character for pass , hides them with * and stores them in 
     ;memory
mov ah,08h ;sets up the call to read a character without echo
           ;the pressed keys ascii code is stored in the al reg but 
           ;it doesnt appear on the screen
int 21h
cmp al,0dh ;would jump  if enter key is preesed
je down
mov [inst+si],al  ;inst is input buffer and si is current index
                  ;its like inst[si] = al would load char by char
mov dl,'*'
mov ah,02h
int 21h
inc si
jmp up1


down:
mov bx,00
mov cx,len ;loop would run
           ; for check for 
           ;the number of 
           ;characters would entered

check:
mov al,[inst+bx]
mov dl,[password+bx]
cmp al,dl
jne fail                                
inc bx
loop check  


correct:
lea dx,msg2
mov ah,09h
int 21h
jmp finish

fail:
lea dx,msg3
mov ah,09h
int 21h

finish:
mov ah,4ch
int 21h


end start
end

;lodsb ;load string byte loads a bute from a amemory location