.model small
.stack 100h
.data 

msg1 db "Inside main$"
msg2 db "Inside proc1$"
msg3 db "Inside proc2$"
newLine db 010d,013d,"$";

.code

main proc
    
    mov ax,@data
    mov ds,ax
    
    mov dx,offset msg1;
    mov ah,09h;
    int 21h;
    
    call print_newLine  
    
    call proc1
    
    call print_newLine  
    
    mov ah,4ch
    int 21h
    main endp

     
     ;proc 1 demonstrates push and pop,call , ret
     
     proc1 proc
        
        mov dx,offset msg2
        mov ah,09h
        int 21h
        
        call print_newLine
        ;demonstrates push and pop
        
        mov ax,1234h
        push ax
        
        
       ; mov ax,0
        pop ax
        
       
        call proc_2
        
        ret  
        
        proc1 endp 
     
     proc_2 proc
        
        mov dx,offset msg3
        mov ah,09h
        int 21h
        
        call print_newLine
        
        ret
        proc_2 endp
     
     
      print_newLine proc
        mov dx,offset newLine
        mov ah,09h
        int 21h
        ret
        print_newLine endp
      
      end main
      
    