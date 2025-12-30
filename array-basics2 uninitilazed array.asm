.model small
.stack 100h
.data

space db " $"
myarr db 5 dup(?)
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
    
    mov ah,01h ;input
    int 21h          
    
    mov [bx],al;
    
    mov dx,offset space  ;space
    mov ah,02h
    int 21h
    
    inc bx
  
    
    loop printArr
     
    mov ah,4ch
    int 21h
         
         
    main endp
end main