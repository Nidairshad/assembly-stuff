.model small
.stack 100h
.code
.data

main proc    
    
    ;program to print a string with carriage return
  L1:  
   mov ah,1
   int 21h
   cmp al,013
   
   je L2
   jmp L1
   
   L2 : mov ah,4ch
   int 21h
   
    
    
    main endp
end main
