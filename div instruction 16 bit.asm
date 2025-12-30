.model small
.stack 100h
.data
.code

main proc
    mov ax, @data
    mov ds, ax

;16 bit division
;divisor in bx ->16 bit reg/mem
;dividend in dx:ax
;quotient in ax
;remainder in dx

mov ax,65000d
mov bx,250d
div  bx

    mov ah, 4Ch
    int 21h
main endp
end main
main