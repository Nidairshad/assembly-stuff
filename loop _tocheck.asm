.model small
.stack 100h

.data

.code

main proc
    mov cx,10 ; counter valuefor loop should be done before the loop
    mov dl,48         ;048 is ascii code for 0 then  + 1 would print 0123456789
 
    L1 : mov ah,2 ;prints
    int 21h ; prints with e cho
    inc dl 
    loop L1 ;would go to line 11 again and again until cx gets 0
    
    mov ah,4ch ;exits the program
    int 21h
    
    main endp
end main
    
     
 
;isko dekhlena loop infinty horha
 ;cx value should be before label as it can lead to infintiy loop 