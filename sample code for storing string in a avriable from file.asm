;reading character from file and storing it 

.model small
.stack 100h
.data

fileName db "UserInfo.txt",0 
fileHandle db 0

.code

main proc
    
    mov ax,@data
    mov ds,ax
    
    ;opens existing file
    mov ah,3Dh
    mov al,0   ;0 for read
    mov dx,offset fileName
    int 21h
    
    mov ah,4ch
    int 21h
    
    
    main endp
end main