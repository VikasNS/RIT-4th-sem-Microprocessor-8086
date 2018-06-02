.Model Small
.DATA
input DW 1234H
file_name db "test.txt",0
open_mod dB 0 ;read mod

buffer_size DW 100
buffer Db 100 DUP(0)

failed_to_open dB 'Unable to open$'

.CODE
START:
	MOV AX,@data
	MOV DS,AX
	
	;TO OPEN FILE
	
	MOV AL,open_mod
	LEA DX,file_name
	MOV AH,3DH
	INT 21H
	
	;IF FILE WAS SUCCESSFULLY OPENED CX=0 ELSE CX=1
	;After opening SUCCESSFULLY, file handler will be in AX
	
	JC failed_to_open_label
	
	
	;TO READ FILE
	
	MOV BX,AX
	MOV CX,buffer_size
	LEA DX,buffer
	MOV AH,3FH
	INT 21H
	
	;TO PRINT FILE
	MOV CX,buffer_size
	LEA SI,buffer
	
	lets_print_label:
		MOV DL,[SI]
		MOV AH,02H
		INT 21H
		INC SI
		LOOP lets_print_label
	
	MOV AH,3EH
	INT 21H
		
	JMP end_it	
		
	
	
	
	failed_to_open_label:
		MOV DL,AX
		ADD DL,'0'
		MOV AH,02h
		INT 21H
	
	end_it:
		MOV AH,4CH
		INT 21H	
END START
