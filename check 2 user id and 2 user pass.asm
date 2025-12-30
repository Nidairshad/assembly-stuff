;check multiple user id and pass

printStr macro msg
    
    lea dx,msg
    mov ah,09h
    int 21h
    
    endm 



fill_screen:
    stosb
    loop fill_screen

    ; wait for key
    mov ah, 00h
    int 16h

    ; return to text mode
    mov ax, 0003h
    int 10h

    endm 
.model small
.stack 100h
.data

user1_id db 'user1'
len_user1 equ $-user1_id
pass1 db '1234'
len_pass1 equ $-pass1

user2_id db 'user2'
len_user2 equ $-user2_id
pass2 db '5678'
len_pass2 equ $-pass2  

;
userInput db 10 dup(0)
passInput db 10 dup(0)

;msgs
user_idMSG db 13,10,"Enter User ID: $"
user_pass  db 13,10,"Enter Password: $"
ok_msg     db 13,10,"Login Successful$"
fail_msg   db 13,10,"Invalid Credentials$"

currentUser db 0
.code

main proc
    
    mov ax,@data
    mov ds,ax
    
    call check_Id
    cmp al,0
    je login_fail
    
    mov currentUser,al
    call check_pass
    cmp al,0
    je login_fail
    
    printStr ok_msg
    jmp exit
    
    login_fail:
    printStr fail_msg
    
    exit:
    
    mov ah,4ch
    int 21h
    
    main endp

check_pass proc
    
     ; clear buffer
    mov di, offset passInput
    mov cx, 10
clr_pass:
    mov byte ptr [di], 0
    inc di
    loop clr_pass

    printStr user_pass

    mov si, 0
read_pass:
    mov ah, 08h
    int 21h
    cmp al, 0Dh
    je decide_pass

    mov [passInput+si], al
    mov dl, '*'
    mov ah, 02h
    int 21h
    inc si
    jmp read_pass

decide_pass:
    cmp currentUser, 1
    je check_p1
    cmp currentUser, 2
    je check_p2
    jmp pass_fail

; ---------- password for user1 ----------
check_p1:
    cmp si, len_pass1
    jne pass_fail

    mov bx, 0
    mov cx, len_pass1
p1_loop:
    mov al, [passInput+bx]
    mov dl, [pass1+bx]
    cmp al, dl
    jne pass_fail
    inc bx
    loop p1_loop

    mov al, 1
    ret

; ---------- password for user2 ----------
check_p2:
    cmp si, len_pass2
    jne pass_fail

    mov bx, 0
    mov cx, len_pass2
p2_loop:
    mov al, [passInput+bx]
    mov dl, [pass2+bx]
    cmp al, dl
    jne pass_fail
    inc bx
    loop p2_loop
    
    
    mov al, 1
    ret

pass_fail:
    mov al, 0
    ret
    check_pass endp

check_Id proc;stores 0 in al if fail
     
       ; clear buffer
    mov di, offset userInput
    mov cx, 10
clr_uid:
    mov byte ptr [di], 0
    inc di
    loop clr_uid

    printStr user_idMSG

    mov si, 0
read_uid:
    mov ah, 01h
    int 21h
    cmp al, 0Dh
    je chk_user1
    mov [userInput+si], al
    inc si
    jmp read_uid
    
    ;compare with user1
    chk_user1:
    cmp si, len_user1
    jne chk_user2

    mov bx, 0
    mov cx, len_user1
u1_loop:
    mov al, [userInput+bx]
    mov dl, [user1_id+bx]
    cmp al, dl
    jne chk_user2
    inc bx
    loop u1_loop

    mov al, 1
    ret
     
    chk_user2:
    cmp si, len_user2
    jne id_fail

    mov bx, 0
    mov cx, len_user2
u2_loop:
    mov al, [userInput+bx]
    mov dl, [user2_id+bx]
    cmp al, dl
    jne id_fail
    inc bx
    loop u2_loop

    mov al, 2
    ret

id_fail:
    mov al, 0
    ret 
    ;compare with user2 
    check_Id endp

end main