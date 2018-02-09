.Model Small
.DATA
Array DB 1,2,3,4,5,6,7,8
ToSearch DB 5
.CODE
START:
	MOV AX,@data
	MOV DS,AX

	MOV AL,ToSearch 
	MOV CX,8
	MOV DI,0

	Comp:
		CMP Array[DI],AL
		JE ENDd
		INC DI
		LOOP Comp
		MOV DL,0
		MOV AH,4CH
		INT 21h
	ENDd:
		MOV DL,1
		MOV AH,4CH
		INT 21H		
END START
