; Write message + transaction number after it (rewrite file)

.model small
.stack 100h

.data
fileName db 'transaction_historydup.txt',0
fileHandle dw ?

msg db 'TIMES OF TRANSACTION YOU DID: '
msgLen equ $ - msg

numOfTrans dw 5        ; example transaction count
numChar dw ?           ; single ASCII digit buffer

.code
main proc
    mov ax, @data
    mov ds, ax

    ;-------------------------
    ; Create file (rewrite)
    ;-------------------------
    mov ah, 3Ch
    mov cx, 0
    mov dx, offset fileName
    int 21h
    mov fileHandle, ax

    ;-------------------------
    ; Write message
    ;-------------------------
    mov ah, 40h
    mov bx, fileHandle
    mov dx, offset msg
    mov cx, msgLen
    int 21h

    ;-------------------------
    ; Convert number to ASCII
    ;-------------------------
    mov ax, numOfTrans
    add ax, '0'         ; only works for 0–9
    mov numChar, ax

    ;-------------------------
    ; Write number AFTER message
    ;-------------------------
    mov ah, 40h
    mov bx, fileHandle
    mov dx, offset numChar
    mov cx, 1
    int 21h

    ;-------------------------
    ; Close file
    ;-------------------------
    mov ah, 3Eh
    mov bx, fileHandle
    int 21h

    ;-------------------------
    ; Exit
    ;-------------------------
    mov ah, 4Ch
    int 21h
main endp

end main
