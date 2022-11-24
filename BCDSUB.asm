;6) 32 bit BCD subtraction

.MODEL TINY
.486
.CODE
.STARTUP
	MOV		EBX,  0FA045321H
	MOV		EDX,  12345678H

	SUB 	DL,  BL
	MOV		AL,  DL
	DAS	
	MOV		CL,  AL
	SBB 	DH,  BH
	MOV		AL,  DH
	DAS
	MOV		CH,  AL

	BSWAP 	EBX
	BSWAP 	EDX
	BSWAP 	ECX

	SBB 	DH,  BH
	MOV		AL,  DH
	DAS
	MOV		CH,  AL
	SBB 	DL,  BL
	MOV		AL,  DL
	DAS	
	MOV		CL,  AL
	
	BSWAP 	ECX
.EXIT
END
