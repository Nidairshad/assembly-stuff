.model small
.stack 100h
.data
.code
main proc
      mov bh,2 ;bh=2 when the line would be executed
      add bh,3 ;bh = 5  
      
      mov dl,bh
      add dl,48  ; fo equivalent ascii code to display 5 -> 5+ 048 = 053
      
      mov ah,2
      int 21h
             
      mov ah,4ch
      int 21h
    
    main endp
end main


