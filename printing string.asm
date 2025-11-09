.model small
.stack 100h
            
.data
str db 'Hello World'  ; as the dollar sign ->string terminator removed the terminator would be finded it would print the ascii codeof below content
var_1 db ?           ; empty space
var_2 dw 25A2H
arr1 db 50,'W', 61h,'4',56,99
arr2 db 20 dup ('$')

.code

main proc
    mov ax,@data
    mov ds,ax
    
    mov dx,offset str ;offset holds the 0th index address of str 
    mov ah,09
    int 21h
    
    main endp
end main


