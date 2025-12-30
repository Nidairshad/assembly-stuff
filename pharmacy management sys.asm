display macro parameter  
    mov dx, offset parameter
    mov ah, 9
    int 21h   
endm      

newLine macro                                
    mov dl, 10                                					    
    mov ah, 2                                 
    int 21h                                                                                                            
    mov dl, 13                                
    mov ah, 2
    int 21h
endm

printChar macro char
    mov dl, char
    mov ah, 2
    int 21h
endm

.model small
.stack 100h

.data                    
    ; File handling variables
    filename db "MEDSTORE.TXT", 0
    filehandle dw 0
    buffer db 500 dup('$')
    read_error_msg db 10,13,'Error reading file!$'
    save_success_msg db 10,13,'Data saved to MEDSTORE.TXT successfully!$'
    file_created_msg db 10,13,'File created successfully!$'
    file_not_found_msg db 10,13,'File does not exist. Save data first.$'
    file_location_msg db 10,13,'File: MEDSTORE.TXT in current directory$'
    
    ; File operations menu
    file_opened_msg db 10,13,'FILE OPERATIONS:', 10,13
                    db 'L - View saved data', 10,13
                    db 'S - Save current data', 10,13
                    db 'Any other key - Return to main menu', 10,13, '$'
    
    ; Password system
    input_password db 'Please Enter Your Password: $'
    password db 'qwerty$'
    incorrect_password db 10,13, 'Incorrect Password$'    
    welcome db 10,13,10,13, '===========|||||WELCOME TO MEDICAL STORE===========|||||$'
   
    ; Main menu messages
    msg1 db 10,13,10,13, 'Choose an Option:$' 
    msg_medicines db 10,13, 'Press 1 to buy medicines$'
    medicines_sold db 10,13,'Press 2 to see medicines statistics$'
    input_again db 10,13,'Please Press one of the above given keys$'
    wrong_input db 10,13,'Wrong Input$'
    exit_program db 10,13,'Press 4 to exit$'
    load_from_file_msg db 10,13,'Press 5 to save/load data$'
   
    ; Medicine selection menu
    msg2 db 10,13,10,13,'What Do You Want To Buy$'
   
    ; Medicine options with prices
    opt1 db 10,13,'1. Panadol                 - 40 Rs$'
    opt2 db 10,13,'2. Paracetamol             - 30 Rs$'
    opt3 db 10,13,'3. Cleritek                - 20 Rs$'
    opt4 db 10,13,'4. Aspirin                 - 20 Rs$'
    opt5 db 10,13,'5. Brufen                  - 10 Rs$'
    opt6 db 10,13,'6. Surbex Z                - 50 Rs$'
    opt7 db 10,13,'7. Arinac                  - 40 Rs$'
    opt8 db 10,13,'8. Sinopharm Vaccine       - 20 Rs$'
    opt9 db 10,13,'9. Pfizer Vaccine          - 800 Rs$'
   
    ; Medicine quantity prompts
    msg_panadol db 10,13,'How many panadols do you want to buy (0-999): $'
    msg_paracetamol db 10,13,'How many paracetamol do you want to buy (0-999): $'
    msg_cleritek db 10,13,'How many cleritek do you want to buy (0-999): $'
    msg_aspirin db 10,13,'How many aspirin do you want to buy (0-999): $'
    msg_brufen db 10,13,'How many brufen do you want to buy (0-999): $'
    msg_surbex db 10,13,'How many subex do you want to buy (0-999): $'
    msg_arinac db 10,13,'How many arinac do you want to buy (0-999): $'
    msg_sinopharm db 10,13,'How many Sinopharm Vaccine do you want to buy (0-999): $'
    msg_pfizer db 10,13,'How many Pfizer Vaccine do you want to buy (0-999): $'
   
    ; Total bill message
    total_msg db 10,13,'Total Bill= $'
    rs_symbol db ' Rs$'
   
    ; Prices Variables
    price_panadol dw 40
    price_paracetamol dw 30
    price_cleritek dw 20    
    price_aspirin dw 20
    price_brufen dw 10
    price_surbex dw 50    
    price_arinac dw 40
    price_sinopharm dw 20
    price_pfizer dw 800    
   
    ; Total amount
    amount_earned db 10,13,'Total amount earned= $'
    amount dw 0
    amount_print db 10,13,'Press 3 to show total amount earned$'
  
    ; Medicines Sold
    panadol_sold dw 0
    paracetamol_sold dw 0
    cleritek_sold dw 0
    aspirin_sold dw 0
    brufen_sold dw 0
    surbex_sold dw 0
    arinac_sold dw 0
    sinopharm_sold dw 0
    pfizer_sold dw 0
   
    ; Medicines Print messages
    panadol_print db 10,13,'Panadol           sold = $'
    pfizer_print db 10,13,'Pfizer Vaccine    sold = $'
    sinopharm_print db 10,13,'Sinopharm Vaccine sold = $'
    arinac_print db 10,13,'Arinac            sold = $'
    surbex_print db 10,13,'Surbex            sold = $'
    aspirin_print db 10,13,'Aspirin           sold = $'
    brufen_print db 10,13,'Brufen            sold = $'
    cleritek_print db 10,13,'Cleritek          sold = $'
    paracetamol_print db 10,13,'Paracetamol       sold = $'
    
    ; Constants
    ten dw 10
    
    ; File format
    file_header db '=== MEDICAL STORE INVENTORY ===', 13, 10
                db '===============================', 13, 10, '$'
    
    total_footer db 13,10,'TOTAL EARNED: $'
    
    rs_footer db ' Rs', 13, 10, '$'
    newline_str db 13, 10, '$'  ; Changed from 'newline' to 'newline_str'
    
    ; String buffers
    num_str db 10 dup('$')
    
.code
main proc
    mov ax, @data
    mov ds, ax
    
    retry_password:         
    display input_password
    newLine
    
    mov bx, offset password
    mov cx, 6
    
    l1:
    mov ah, 7
    int 21h
    cmp al, [bx]
    jne incorrect
    inc bx
    loop l1
    
    start:
    newLine  
    call menu
    newLine
   
    mov ah, 1
    int 21h
    
    cmp al, '1'
    je menu2  
    cmp al, '2'
    je medicines_stats
    cmp al, '3'
    je show_amount
    cmp al, '4'
    je exit
    cmp al, '5'
    je file_operations
    
    display wrong_input
    display input_again
    jmp start
    
    ; Medicine purchase procedures
    panadol:
        display msg_panadol
        call read_3digit_number_silent
        cmp ax, 999
        jle panadol_valid
        mov ax, 0
    panadol_valid:
        add panadol_sold, ax
        mov bx, ax
        mov ax, price_panadol
        mul bx
        add amount, ax
        mov bx, ax
        newLine
        display total_msg
        call print_3digits
        display rs_symbol
        newLine
        jmp start
    
    paracetamol:
        display msg_paracetamol
        call read_3digit_number_silent
        cmp ax, 999
        jle paracetamol_valid
        mov ax, 0
    paracetamol_valid:
        add paracetamol_sold, ax
        mov bx, ax
        mov ax, price_paracetamol
        mul bx
        add amount, ax
        mov bx, ax
        newLine
        display total_msg
        call print_3digits
        display rs_symbol
        newLine
        jmp start
    
    cleritek:
        display msg_cleritek
        call read_3digit_number_silent
        cmp ax, 999
        jle cleritek_valid
        mov ax, 0
    cleritek_valid:
        add cleritek_sold, ax
        mov bx, ax
        mov ax, price_cleritek
        mul bx
        add amount, ax
        mov bx, ax
        newLine
        display total_msg
        call print_3digits
        display rs_symbol
        newLine
        jmp start
    
    aspirin:
        display msg_aspirin
        call read_3digit_number_silent
        cmp ax, 999
        jle aspirin_valid
        mov ax, 0
    aspirin_valid:
        add aspirin_sold, ax
        mov bx, ax
        mov ax, price_aspirin
        mul bx
        add amount, ax
        mov bx, ax
        newLine
        display total_msg
        call print_3digits
        display rs_symbol
        newLine
        jmp start
    
    brufen:
        display msg_brufen
        call read_3digit_number_silent
        cmp ax, 999
        jle brufen_valid
        mov ax, 0
    brufen_valid:
        add brufen_sold, ax
        mov bx, ax
        mov ax, price_brufen
        mul bx
        add amount, ax
        mov bx, ax
        newLine
        display total_msg
        call print_3digits
        display rs_symbol
        newLine
        jmp start
    
    surbex:
        display msg_surbex
        call read_3digit_number_silent
        cmp ax, 999
        jle surbex_valid
        mov ax, 0
    surbex_valid:
        add surbex_sold, ax
        mov bx, ax
        mov ax, price_surbex
        mul bx
        add amount, ax
        mov bx, ax
        newLine
        display total_msg
        call print_3digits
        display rs_symbol
        newLine
        jmp start
    
    arinac:
        display msg_arinac
        call read_3digit_number_silent
        cmp ax, 999
        jle arinac_valid
        mov ax, 0
    arinac_valid:
        add arinac_sold, ax
        mov bx, ax
        mov ax, price_arinac
        mul bx
        add amount, ax
        mov bx, ax
        newLine
        display total_msg
        call print_3digits
        display rs_symbol
        newLine
        jmp start
    
    sinopharm:
        display msg_sinopharm
        call read_3digit_number_silent
        cmp ax, 999
        jle sinopharm_valid
        mov ax, 0
    sinopharm_valid:
        add sinopharm_sold, ax
        mov bx, ax
        mov ax, price_sinopharm
        mul bx
        add amount, ax
        mov bx, ax
        newLine
        display total_msg
        call print_3digits
        display rs_symbol
        newLine
        jmp start
    
    pfizer:
        display msg_pfizer
        call read_3digit_number_silent
        cmp ax, 999
        jle pfizer_valid
        mov ax, 0
    pfizer_valid:
        add pfizer_sold, ax
        mov bx, ax
        mov ax, price_pfizer
        mul bx
        add amount, ax
        mov bx, ax
        newLine
        display total_msg
        call print_3digits
        display rs_symbol
        newLine
        jmp start
    
    ; Show Medicine Statistics
    medicines_stats:
        display panadol_print
        mov bx, panadol_sold
        call print_3digits
        
        display paracetamol_print
        mov bx, paracetamol_sold
        call print_3digits
        
        display cleritek_print
        mov bx, cleritek_sold
        call print_3digits
        
        display aspirin_print
        mov bx, aspirin_sold
        call print_3digits
        
        display brufen_print
        mov bx, brufen_sold
        call print_3digits
        
        display arinac_print
        mov bx, arinac_sold
        call print_3digits
        
        display pfizer_print
        mov bx, pfizer_sold
        call print_3digits
        
        display sinopharm_print
        mov bx, sinopharm_sold
        call print_3digits
        
        jmp start
    
    ; Show Total Amount
    show_amount: 
        display amount_earned
        mov bx, amount
        call print_3digits
        printChar ' '
        display rs_symbol
        jmp start 
    
    ; File operations menu
    file_operations:
        newLine
        display file_opened_msg
        newLine
        mov ah, 1
        int 21h
        cmp al, 'L'
        je view_file_data
        cmp al, 'l'
        je view_file_data
        cmp al, 'S'
        je save_to_file
        cmp al, 's'
        je save_to_file
        jmp start
    
    ; View file data
    view_file_data:
        call read_file_data
        jmp start
    
    ; Save data to file
    save_to_file:
        call save_file_data
        jmp start
    
    incorrect:
        display incorrect_password
        newLine
        jmp retry_password 
        
    exit:
        mov ah, 4ch
        int 21h
            
main endp

; Main menu display
menu proc
    display welcome
    display msg1            
    display msg_medicines
    display medicines_sold
    display amount_print
    display load_from_file_msg
    display exit_program
    ret
menu endp

; Medicine selection menu
menu2 proc  
    display msg2
    display opt1
    display opt2
    display opt3
    display opt4
    display opt5
    display opt6
    display opt7
    display opt8
    display opt9
    
    newLine
    mov ah, 1
    int 21h
    
    cmp al, '1'
    je panadol  
    cmp al, '2'
    je paracetamol
    cmp al, '3'
    je cleritek
    cmp al, '4'
    je aspirin
    cmp al, '5'
    je brufen  
    cmp al, '6'
    je surbex
    cmp al, '7'
    je arinac
    cmp al, '8'
    je sinopharm
    cmp al, '9'
    je pfizer
    
    ; Invalid input
    newLine
    display wrong_input
    jmp menu2
menu2 endp 

; Read 3-digit number without double echo
read_3digit_number_silent proc
    push bx
    push cx
    push dx
    
    mov cx, 3
    mov bx, 0
    
    read_digits_silent:
        mov ah, 7
        int 21h
        
        cmp al, 13
        je read_done_silent
        cmp al, '0'
        jb read_digits_silent
        cmp al, '9'
        ja read_digits_silent
        
        ; Echo once
        mov dl, al
        mov ah, 2
        int 21h
        
        ; Convert and accumulate
        sub al, '0'
        mov ah, 0
        
        push ax
        mov ax, bx
        mul ten
        mov bx, ax
        pop ax
        add bx, ax
        
        loop read_digits_silent
    
    read_done_silent:
    mov ax, bx
    
    pop dx
    pop cx
    pop bx
    ret
read_3digit_number_silent endp

; Print 3-digit number
print_3digits proc
    push ax
    push bx
    push cx
    push dx
    
    mov ax, bx
    mov bx, 10
    xor cx, cx
    
    cmp ax, 0
    jne extract_digits
    mov dl, '0'
    mov ah, 2
    int 21h
    jmp print_done
    
    extract_digits:
        xor dx, dx
        div bx
        push dx
        inc cx
        cmp ax, 0
        jne extract_digits
    
    print_digits_loop:
        pop dx
        add dl, '0'
        mov ah, 2
        int 21h
        loop print_digits_loop
    
    print_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_3digits endp

; Convert number to string
number_to_string proc
    push ax
    push bx
    push cx
    push dx
    push di
    
    lea di, num_str
    mov bx, 10
    xor cx, cx
    
    cmp ax, 0
    jne convert_loop
    mov byte ptr [di], '0'
    mov byte ptr [di+1], '$'
    jmp convert_done
    
    convert_loop:
        xor dx, dx
        div bx
        add dl, '0'
        push dx
        inc cx
        test ax, ax
        jnz convert_loop
    
    reverse_loop:
        pop dx
        mov [di], dl
        inc di
        loop reverse_loop
    
    mov byte ptr [di], '$'
    
    convert_done:
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
number_to_string endp

; Save data to file (SIMPLIFIED VERSION)
save_file_data proc
    push ax
    push bx
    push cx
    push dx
    push si
    
    ; Create new file (overwrites if exists)
    mov ah, 3Ch
    mov cx, 0
    lea dx, filename
    int 21h
    jc save_error
    
    mov filehandle, ax
    
    ; Write header
    mov ah, 40h
    mov bx, filehandle
    lea dx, file_header
    mov cx, 66  ; Length of header
    int 21h
    
    ; Write Panadol info
    lea dx, panadol_print
    mov ah, 40h
    mov bx, filehandle
    mov cx, 23  ; Length
    int 21h
    
    mov bx, panadol_sold
    call number_to_string
    mov ah, 40h
    mov bx, filehandle
    lea dx, num_str
    mov cx, 0
    mov si, dx
    call strlen_proc
    int 21h
    
    ; Write newline
    mov ah, 40h
    mov bx, filehandle
    lea dx, newline_str  ; Changed from newline to newline_str
    mov cx, 2
    int 21h
    
    ; Write Paracetamol info
    lea dx, paracetamol_print
    mov ah, 40h
    mov bx, filehandle
    mov cx, 25
    int 21h
    
    mov bx, paracetamol_sold
    call number_to_string
    mov ah, 40h
    mov bx, filehandle
    lea dx, num_str
    mov cx, 0
    mov si, dx
    call strlen_proc
    int 21h
    
    ; Write newline
    mov ah, 40h
    mov bx, filehandle
    lea dx, newline_str  ; Changed from newline to newline_str
    mov cx, 2
    int 21h
    
    ; Write Cleritek info
    lea dx, cleritek_print
    mov ah, 40h
    mov bx, filehandle
    mov cx, 22
    int 21h
    
    mov bx, cleritek_sold
    call number_to_string
    mov ah, 40h
    mov bx, filehandle
    lea dx, num_str
    mov cx, 0
    mov si, dx
    call strlen_proc
    int 21h
    
    ; Write newline
    mov ah, 40h
    mov bx, filehandle
    lea dx, newline_str  ; Changed from newline to newline_str
    mov cx, 2
    int 21h
    
    ; Write Aspirin info
    lea dx, aspirin_print
    mov ah, 40h
    mov bx, filehandle
    mov cx, 21
    int 21h
    
    mov bx, aspirin_sold
    call number_to_string
    mov ah, 40h
    mov bx, filehandle
    lea dx, num_str
    mov cx, 0
    mov si, dx
    call strlen_proc
    int 21h
    
    ; Write newline
    mov ah, 40h
    mov bx, filehandle
    lea dx, newline_str  ; Changed from newline to newline_str
    mov cx, 2
    int 21h
    
    ; Write Brufen info
    lea dx, brufen_print
    mov ah, 40h
    mov bx, filehandle
    mov cx, 20
    int 21h
    
    mov bx, brufen_sold
    call number_to_string
    mov ah, 40h
    mov bx, filehandle
    lea dx, num_str
    mov cx, 0
    mov si, dx
    call strlen_proc
    int 21h
    
    ; Write newline
    mov ah, 40h
    mov bx, filehandle
    lea dx, newline_str  ; Changed from newline to newline_str
    mov cx, 2
    int 21h
    
    ; Write Arinac info
    lea dx, arinac_print
    mov ah, 40h
    mov bx, filehandle
    mov cx, 20
    int 21h
    
    mov bx, arinac_sold
    call number_to_string
    mov ah, 40h
    mov bx, filehandle
    lea dx, num_str
    mov cx, 0
    mov si, dx
    call strlen_proc
    int 21h
    
    ; Write newline
    mov ah, 40h
    mov bx, filehandle
    lea dx, newline_str  ; Changed from newline to newline_str
    mov cx, 2
    int 21h
    
    ; Write Surbex info
    lea dx, surbex_print
    mov ah, 40h
    mov bx, filehandle
    mov cx, 19
    int 21h
    
    mov bx, surbex_sold
    call number_to_string
    mov ah, 40h
    mov bx, filehandle
    lea dx, num_str
    mov cx, 0
    mov si, dx
    call strlen_proc
    int 21h
    
    ; Write newline
    mov ah, 40h
    mov bx, filehandle
    lea dx, newline_str  ; Changed from newline to newline_str
    mov cx, 2
    int 21h
    
    ; Write Sinopharm info
    lea dx, sinopharm_print
    mov ah, 40h
    mov bx, filehandle
    mov cx, 26
    int 21h
    
    mov bx, sinopharm_sold
    call number_to_string
    mov ah, 40h
    mov bx, filehandle
    lea dx, num_str
    mov cx, 0
    mov si, dx
    call strlen_proc
    int 21h
    
    ; Write newline
    mov ah, 40h
    mov bx, filehandle
    lea dx, newline_str  ; Changed from newline to newline_str
    mov cx, 2
    int 21h
    
    ; Write Pfizer info
    lea dx, pfizer_print
    mov ah, 40h
    mov bx, filehandle
    mov cx, 23
    int 21h
    
    mov bx, pfizer_sold
    call number_to_string
    mov ah, 40h
    mov bx, filehandle
    lea dx, num_str
    mov cx, 0
    mov si, dx
    call strlen_proc
    int 21h
    
    ; Write newline
    mov ah, 40h
    mov bx, filehandle
    lea dx, newline_str  ; Changed from newline to newline_str
    mov cx, 2
    int 21h
    
    ; Write total amount
    mov ah, 40h
    mov bx, filehandle
    lea dx, total_footer
    mov cx, 16
    int 21h
    
    mov bx, amount
    call number_to_string
    mov ah, 40h
    mov bx, filehandle
    lea dx, num_str
    mov cx, 0
    mov si, dx
    call strlen_proc
    int 21h
    
    ; Write Rs
    mov ah, 40h
    mov bx, filehandle
    lea dx, rs_footer
    mov cx, 5
    int 21h
    
    ; Close file
    mov ah, 3Eh
    mov bx, filehandle
    int 21h
    
    display save_success_msg
    newLine
    
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    
    save_error:
        display read_error_msg
        newLine
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret
save_file_data endp

; Read file data
read_file_data proc
    push ax
    push bx
    push cx
    push dx
    
    ; Try to open file
    mov ah, 3Dh
    mov al, 0
    lea dx, filename
    int 21h
    jnc file_exists
    
    ; File doesn't exist
    display file_not_found_msg
    newLine
    jmp read_done
    
    file_exists:
    mov filehandle, ax
    
    ; Read file
    mov ah, 3Fh
    mov bx, filehandle
    mov cx, 499
    lea dx, buffer
    int 21h
    jc read_error
    
    ; Null terminate
    mov si, dx
    add si, ax
    mov byte ptr [si], '$'
    
    ; Close file
    mov ah, 3Eh
    mov bx, filehandle
    int 21h
    
    ; Display contents
    newLine
    display buffer
    newLine
    jmp read_done
    
    read_error:
        mov ah, 3Eh
        mov bx, filehandle
        int 21h
        display read_error_msg
        newLine
    
    read_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
read_file_data endp

; String length helper
strlen_proc proc
    push si
    mov cx, 0
strlen_loop:
    cmp byte ptr [si], '$'
    je strlen_done
    inc cx
    inc si
    jmp strlen_loop
strlen_done:
    pop si
    ret
strlen_proc endp

end main