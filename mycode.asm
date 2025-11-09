.model small ;allocates size ,small:one data segment and one code segment       
.stack 100h ;256 byte
.data 
.code                                         

main proc 
    
    mov dl,65 ;or 'A' can also be used
    mov ah ,2h ; printf 2 prints
    int 21

           
    
             
          
    
    main endp
end main