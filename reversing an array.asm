.model small
.stack 100h
.data

;reversing an array

myarr db 1,2,3,4,5
str db "Array Elements : $"

.code 

main proc 
     
     ;bx / si points to memeory address 
    mov ax,@data
    mov ds,ax  
    
    mov ah,09h
    mov dx,offset str
    int 21h
    
    ;we will store the arr in bx as it would increment it would point to next element block 
    ;si could also be used here 
    
    mov bx,offset myarr   
    
    mov cx,5
    
    printArr: 
    
    mov al,[bx + 4] ;bx address moves to al beacuse we have to convert the value from ascii to num     
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h 
    
    mov dl,' '
    mov ah,02h
    int 21h
    
    dec bx  
 
    
    loop printArr
     
    mov ah,4ch
    int 21h
         
         
    main endp
end main