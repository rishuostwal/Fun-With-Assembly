.MODEL 		SMALL
 
.STACK 		100H
 
.DATA
B2A			DB		'0123456789ABCDEF'
 
.CODE
			MOV		AX,@DATA 
			MOV		DS,AX
			MOV		ES,AX
 
			
			MOV		CX,10 
			CALL	PRBASE
EXIT:
			MOV		AX,4C00H
			INT		21H
 
PRBASE		PROC	NEAR			;Given a WORD value in AX print
			XOR		DX,DX
			MOV		BX,0			;it in the base in CX.
			DIV		CX				;Divide DX:AX by CX
			AND		AX,AX			;Is quotient zero?
			JZ		PRINT			;Yes print remainder
			PUSH	DX
			CALL	PRBASE			;and do again.
			POP		DX				;Restore previous reminder
	
PRINT:
			MOV		BX,DX			;Print remainder in AH
			MOV		AH,2
			MOV		DL,[B2A+BX]		;Convert Binary to ASCII
			INT		21H				;Print
			RET
PRBASE		ENDP
 
END
