;about grpahical interuupt

.model small
.stack 100h
.data
.code

main proc
    
    mov ax,@data
    mov ds,ax
    
    mov al,13h ;graphical mode .40x25. 256 colours.300 x 200 pixels .1 page
    
    mov ah,0
    int 10h
    
   ; set curson shape
;    ch = cursor start line
;    cl= botto, cursor line
    
    ;FOR CURSOR SHAPESS
    ;hide bk=linking text cursor
    mov ch,32
    mov ah,01h
    int 10h
     
    mov ah,01h
    int 21h
    ;---------
    ;show standrad blinking text cursor
    mov ch,6
    mov cl,7
    mov ah,1
    int 10h  
    
    mov ah,01h
    int 21h
    ;---------
    ;show box shaped blinking text cursro
    mov ch,0
    mov cl,7
    mov ah,1
    int 10h
    
    mov ah,01h
    int 21h 
    ;FOR MOVING CURSOR POSITION EXAMPLE IN end  IF
    ;window size 40x25 ->upto 79 col and 24 rows
    mov dh,24
    mov dl,39
    mov bh,0 ;page number
    mov ah,02h
    int 10h
    
    
    mov ah,01h
    int 21h
   
    exit:
    mov ah,4ch
    int 21h
    
    main endp
end main
