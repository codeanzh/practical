; BINARY SEARCH

.model small
.stack
.386
.data

ARRAY DB 9 DUP(?)
MESS01 DB 13,10,"MAX. NO. OF ELEMENTS IN ARRAY IS 9 $" 
MESS02 DB 13,10,"  $"
MESS1 DB 13,10,"ENTER THE NUMBER OF ELEMENTS: $"
MESS0 DB 13,10,"ENTER THE NUMBER: $"
MESS2 DB 13,10,"ENTER THE ELEMENT TO BE SEARCHED: $"
MESS3 DB 13,10,"VALUE FOUND AT LOCATION- $"
MESS4 DB 13,10,"VALUE NOT FOUND!!!$"
ErrMess DB 13,10,"ERROR IN INPUT DIGIT$"


DAT DB ?
number dw ?
MYHIGH Dw ?
MYLOW Dw ?
POS DW ?


.code
.startup

MOV DX,OFFSET MESS01
MOV AH,09
INT 21H


MOV DX,OFFSET MESS02
MOV AH,09
INT 21H


MOV DX,OFFSET MESS1
MOV AH,09
INT 21H

MOV AH,01
INT 21H

cmp al,39h
jbe abc

MOV DX,OFFSET ErrMess
MOV AH,09
INT 21H

jmp myexit

abc:

and al,0fh
mov ah,0
mov number,ax
MOV CX,AX	;SET COUNTER AL TIMES
MOV DI,0

;INPUT ELEMENTS IN ARRAY


MYLOOP:		
MOV DX,OFFSET MESS0
MOV AH,09
INT 21H

;tens digit


MOV AH,01
INT 21H
cmp al,39h
jbe abc2

MOV DX,OFFSET ErrMess
MOV AH,09
INT 21H

jmp myexit

abc2:

and al,0fh
shl al,4
mov bl,al


;units digit


MOV AH,01
INT 21H

cmp al,39h

jbe abcx

MOV DX,OFFSET ErrMess
MOV AH,09
INT 21H

jmp myexit
abcx:
and al,0fh
add al,bl
MOV ARRAY[DI],AL
INC DI
LOOP MYLOOP



;INPUT ELEMENT TO BE SEARCHED


MOV DX,OFFSET MESS2
MOV AH,09
INT 21H

;tens digit


MOV AH,01
INT 21H

cmp al,39h
jbe abcl

MOV DX,OFFSET ErrMess
MOV AH,09
INT 21H

jmp myexit
abcl:

and al,0fh
shl al,4
mov bl,al

;units digit

MOV AH,01
INT 21H

cmp al,39h
jbe abcm

MOV DX,OFFSET ErrMess
MOV AH,09
INT 21H

jmp myexit
abcm:

and al,0fh
add al,bl
mov DAT,AL


;SEARCH PROCESS


DEC NUMBER
mov AX,number
mov ah,0
mov MYHIGH,ax
mov MYLOW,0
mov di,0
MOV CL,DAT	;MOV DATA TO BE SEARCHED IN CL(PERMANENT)
mov bl,2	;For division by two each successive time
mov bh,0

MYLP:
MOV SI,MYHIGH		;LOOP TILL MYLOW<=MYHIGH
CMP MYLOW,SI
JA NTFOUND
mov ax,MYHIGH
ADD ax,MYLOW

div BL		;AL=(MYLOW+MYHIGH)/2	;Dividend->AX, Divisor->BL=2
MOV AH,0	;CLEAR REMAINDER

MOV DI,AX
cmp ARRAY[DI],CL		
JA ABOVE
JB BELOW
MOV POS,DI
INC POS
JMP FND

ABOVE:
DEC di
CMP DI,0
JL NTFOUND	;IF DI<0 THEN OUTOF BOUND INDEXING(SIGNED CHECK->JL)
MOV MYHIGH,di	;MYHIGH=DI-1
JMP MYLP

BELOW:
INC DI
MOV MYLOW,DI	;MYLOW=MYHIGH+1
JMP MYLP


FND:
MOV DX,OFFSET MESS3
MOV AH,09
INT 21H
ADD POS,30H			;FIND ELEMENT LOCATION
MOV DX,POS
MOV AH,02
INT 21H
JMP myexit

NTFOUND:
MOV DX,OFFSET MESS4
MOV AH,09
INT 21H

myexit:
.EXIT
END



;;OUTPUT
;C:\masm611\bin>btest.exe

;MAX. NO. OF ELEMENTS IN ARRAY IS 9

;ENTER THE NUMBER OF ELEMENTS: 5
;ENTER THE NUMBER: 12
;ENTER THE NUMBER: 32
;ENTER THE NUMBER: 45
;ENTER THE NUMBER: 56
;ENTER THE NUMBER: 89
;ENTER THE ELEMENT TO BE SEARCHED: 45
;VALUE FOUND AT LOCATION- 3
