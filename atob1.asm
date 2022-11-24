.model tiny
.data

array1 db 8 dup(?)


.code
        
mov si  ,offset array1
mov cx , 8 
mov al, '1'
mov bl , 2

X:
mov ah,00h
div bl
mov array1[si] , ah 
inc si
loop X 

mov si, offset array1
mov cx, 8     
add si,8 

Z:
 mov dl, array1[si-1]
 add dl,30h
 mov ah, 02h
 int 21h
 dec si
 loop Z
 
  
.exit 
end

