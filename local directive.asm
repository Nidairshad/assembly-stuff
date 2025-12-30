printStar macro
    ;local loop1
    loop1:
    mov ah,02h
    mov dl,'*'
    int 21h
endm

.model small
.stack 100h
.data

.code

main proc
    
    printStar
    printStar         ;comment out this line and you ll get error because of locak directive is commented out uncomment it and check it
    
    mov ah,4ch
    int 21h
    
    main endp
end main
