;write a program to add two numbers and display the resukt

.model small
.stack 100h
.data
result db ?
num1 db 9
num2 db 3

.code 

main proc 
      
          mov ax,@data ;initiliz the data segment as variable used
          mov ds,ax
          
          mov al,num1
          mov ah,0        ;8 bit number so hgiher 8 bits set to 0
          mov bl,num2
          div bl
          mov result,al;store it to result vairable
          
          add result,30h ;convert num into ascii
          
          mov dl,result
          mov ah,2 ;print
          int 21h
          
          mov ah,4ch ;exit
          int 21h
    
    main endp
end main
    
    

