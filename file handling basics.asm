.model small
.stack 100h
.data

;saved in my build as this is a relative path 
; i.e it doesnt start with a drive letter like c:\ , dos 
;creates the file in the current default directory
;where all prgram is saved which is myBuild folder
file db 'myFile.txt',0 
;0 used here as a null for manual looping like wehn cmp al,0 je done 
;$is also a terminator used generallly with mov ah,09h which is dos ifcntion and would work until it foinds "$" char
 
text db 'hello world.$'
handle dw ?
.code

main proc
   
   
   mov ax,@data
   mov ds,ax
;   
;   mov ah,3ch ;creates file
;   mov cx,0    ;cx = 0 : normal file
;               ;cx = 1 ;read only file
;               ;cx = 2 ;hidden file
;               ;cx = 4 system file
;               ;cx = 16 archive file
;   mov dx,offset file
;   int 21h
   
   
  ; mov ah,41h ;dos deltes file  
;   
;   mov dx,offset file
;   int 21h  
;----------------------
;open a file
;note:                              ;
;
;. The file will not open if you change the file name.
;. 3dh will only open the already created file.

  ; mov ah,3dh ;open exisiting file
;   mov al,0 ;acess mode al = 0 ; read,al =1 write al = 2 read or write
;   mov dx,offset file
;   
;   int 21h

mov ah,3dh  ;open exiisitng file
mov al,1 ;wrtie
mov dx,offset file
int 21h 
mov handle,ax ;saves the file mode i handle

mov ah,40h   ;write to file
mov bx,handle              ;file handle put in bx
mov dx,offset text
mov cx,12 ; set counter acc to you string 
  int 21h

   
   mov ah,4ch
   int 21h   
   
   ;creating  a file
   
   
   main endp
end main