.Model Small
.DATA
input DW 1234H
result DW ?
.CODE
START:
	MOV AX,@data
	MOV DS,AX

	MOV AX,input
	MOV CX,16
	MOV BX,0

	Rotate:
		ROR AX,1
		JNC Next
		INC BX
	Next:
		LOOP Rotate
		
		MOV result,BX
		
		MOV DL,BL  ;To display
		ADD DL,'0'
		MOV AH,2H
		INT 21H
		
		MOV AH,4CH
		INT 21H		
END START
