;program to check pass word and user id and the window then turns colourful
;using graphical interrupts  

;TODO FROM GRAPHICAL INTERUUPTS
macro activeColour 
    
    MOV AH, 06h      ; BIOS scroll up function
    XOR AL, AL       ; AL=00h means clear the entire window
    XOR CX, CX       ; CH, CL = top left corner (row 0, column 0)
    MOV DX, 184FH    ; DH, DL = bottom right corner (row 24, column 79)
    MOV BH, 1Eh      ; Set attribute: Yellow text on Blue background (1=Blue BKG, E=Yellow FGC)
    INT 10H          ; Call video interrupt


    activeColour endm

macro newLine
    mov dl,013d
    mov ah,02h
    int 21h
    
    mov dl,010d
    mov ah,02h
    int 21h
    
    newLine endm

.model small
.stack 100h
.data 

user_id db 'user'
len_id equ ($-user_id)
password db '1234'
len_password equ ($-password)

id_msg db "enter your user id : $" 
pass_msg db "enter your password :$ " 
correct_msg db "correct password enetered! WELCOME$"  
incorrectID db "invalid user id !$"  
incorrectPass db "invalid user password !$" 

userInput db 10 dup(?)
passInput db 10 dup(?)

.code

main proc
    mov ax,@data
    mov ds,ax
    
    lea dx, id_msg
    mov ah,09h
    int 21h
    newLine
    call check_id
    cmp al,0   ;if al !=0 then exit and al = 0  when correct user id
    je continue 
    jne invalidId
    
    newLine
    continue:
    newLine
    
    lea dx, pass_msg
    mov ah,09h
    int 21h
    call check_pass
    cmp al,0
    je correct
    jne invalidPass
   
    correct:
    activeColour
    
    newLine 
    call change_Screen
    
    mov dx,offset correct_msg
    mov ah,09h 
    
    
    int 21h
    mov ah,4ch
    int 21h
    
    invalidPass:
     mov dx,offset incorrectPass
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h
    invalidId:
    
    mov dx,offset incorrectId
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h
    main endp

change_Screen proc
    
    ret
    change_Screen endp

;--------
check_pass proc
    
       ;--------------------------------------------
    ; 1. CLEAR previous password input
    ;--------------------------------------------
    mov di, offset passInput
    mov cx, 10 
    
clear_pass_loop:
    mov byte ptr [di], 0
    inc di
    loop clear_pass_loop

   

    ;--------------------------------------------
    ; 3. READ PASSWORD CHAR-BY-CHAR
    ;--------------------------------------------
    mov si, 0                      ; si = typed length

read_loop:
    mov ah, 08h                    ; read without echo
    int 21h
    cmp al, 0Dh                    ; Enter key?
    je compare_phase

    mov [passInput + si], al       ; store char
    mov dl, '*'                    ; show *
    mov ah, 02h
    int 21h

    inc si                         ; increase length
    jmp read_loop

    ;--------------------------------------------
    ; 4. COMPARE LENGTHS FIRST
    ;--------------------------------------------
compare_phase:
    cmp si, len_password
    jne fail                       ; length mismatch
  ;--------------------------------------------
    ; 5. COMPARE EACH CHARACTER
    ;--------------------------------------------
    mov bx, 0
    mov cx, len_password

compare_loop:
    mov al, [passInput + bx]
    mov dl, [password + bx]
    cmp al, dl
    jne fail

    inc bx
    loop compare_loop

    ;--------------------------------------------
    ; 6. IF ALL MATCH ? SUCCESS
    ;--------------------------------------------
    
   
    mov al, 0                      ; password correct
    ret

    ;--------------------------------------------
    ; 7. FAIL BRANCH
    ;--------------------------------------------
fail:
    
  
    mov al, 1                      ; incorrect
   
    ret
    check_pass endp

check_id proc
    
      ;--------------------------------------------
    ; 1. CLEAR previous password input
    ;--------------------------------------------
    mov di, offset userInput
    mov cx, 10 
    
clear_id_loop2:
    mov byte ptr [di], 0
    inc di
    loop clear_id_loop2

    

    ;--------------------------------------------
    ; 3. READ PASSWORD CHAR-BY-CHAR
    ;--------------------------------------------
    mov si, 0                      ; si = typed length

read_loop2:
    mov ah, 01h                    ; read without echo
    int 21h
    cmp al, 0Dh                    ; Enter key?
    je compare_phase2

    mov [userInput + si], al       ; store char
   

    inc si                         ; increase length
    jmp read_loop2
    
    
       ;--------------------------------------------
    ; 4. COMPARE LENGTHS FIRST
    ;--------------------------------------------
compare_phase2:
    cmp si, len_id
    jne failID                       ; length mismatch

    ;--------------------------------------------
    ; 5. COMPARE EACH CHARACTER
    ;--------------------------------------------
    mov bx, 0
    mov cx, len_id

compare_loopID:
    mov al, [userInput + bx]
    mov dl, [user_id + bx]
    cmp al, dl
    jne fail

    inc bx
    loop compare_loopID

    ;--------------------------------------------
    ; 6. IF ALL MATCH ? SUCCESS
    ;--------------------------------------------
   
   
    mov al, 0                      ; password correct
    ret

    ;--------------------------------------------
    ; 7. FAIL BRANCH
    ;--------------------------------------------
failID:
  
    mov al, 1                      ; incorrect
 
    ret
    check_id endp
end main


