.model small
.stack 100h

.data  
var db 'Hello World$' 
var1 db 'coal lab' 
nl db 0ah,0dh,'$'

.code

main proc  
    
    mov ax,@data ;
    mov ds,ax
    
    mov ah,9h
    mov dx,offset var
    int 21h
            
    mov dl,0dh ;0dh = carriage return //ctrl q select cmnt out
    mov ah,2h
    int 21h  
    
    mov dl,0ah ;0dh = carriage return //ctrl q select cmnt out
    mov ah,2h
    int 21h            
    
    mov ah,9h     ; for printning
    mov dx,offset var1 
    int 21h
    
    mov ah,4ch
    int 21h
   
    
    main endp
end main