.model small
.data

array1 db 1 dub<0>

.code


mov si,0
mov cx,8


enter:
       mov ah,01h
       int 21h
       sub al,30h
       mov array1[si],al
       inc si
loop enter 
   
   
   
mov dl,10
mov ah,02h
int 21h

mov si,0
mov cx,8
     
mov bl,2
mov ax,0001h
mov di,7

second: 
        cmp array1[di],1
        jne one
        add si,ax
          
one: 

        mul bl
        dec di
       
loop second

mov dx,si
mov ah,02H
int 21H 
  
.exit 
end