assume cs:code,ds:data



data segment
	numbers db 5,8,2,3,9 
	count dw count-numbers		
data ends



code segment
start:
	mov ax,data
	mov ds,ax
	
	
	
	MOV SI,DI
	ADD SI,count
	Dec SI
	
	MOV cx,count
	DEC cx
	outer:
		LEA DI,numbers
		inner:
			mov AL,[DI]
			MOV BL,[DI+1]
			
			CMP BL,AL
			JA no_swap
			MOV [DI+1],AL
			MOV [DI],BL
			
			no_swap:
			    INC DI
				CMP SI,DI
				JA inner
		loop outer
		
	
	
	
	lea si,numbers
	mov cx,count
	next:
	
	mov dl,[si]
	add dl,30h
	mov ah,02h
	int 21h
	
	mov dl," "
	int 21h
	inc si
	
	loop next
	
	mov ah,4ch
	int 21h
	
	
code ends
end start
