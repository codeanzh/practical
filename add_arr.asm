

.model tiny
.data
    
msg dw "the array is: $"    
msg2 dw "the added array is: $"
array1 db 0,1,2,3
array2 db 4,5,6,7   

.code

mov dx, offset msg
mov ah , 09h
int 21h

mov si, offset array1
mov cx, 4      

X:
 mov dl, [si]
 mov ah, 02h
 int 21h
 inc si
 loop X
 
mov si, offset array2      
mov cx, 4      

Y:
 mov dl, [si]
 mov ah, 02h
 int 21h
 inc si
 loop Y  
 

mov dl, 10
mov ah , 02h
int 21h

mov dx, offset msg2
mov ah , 09h
int 21h


mov di , offset array2
mov si, offset array1
mov cx, 4 

Z:
 mov dl, [si]
 add dl, [di]      
 mov ah,02h
 int 21h
 inc si
 inc di
 loop Z

.exit
end


