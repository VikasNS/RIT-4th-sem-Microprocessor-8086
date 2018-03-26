; 
disp macro mesg 
	lea dx,mesg 
	mov ah, 9 
	int 21h 
	endm 
; 

.model small

.data
	password db "abc123"
	len dw len-password
	limit_exceed db "  Max limit exceeded,locking keyboard  $  "
	correct db "  login successfull  $"
	wrong db " login failed  $ "
	limit db 3

.code
	start:
		mov ax,@data
		mov ds,ax
		mov bl,0
		next_trial:
			cmp bl,limit
			jz limit_exceed_label
			inc bl
			mov cx,len
			lea si,password
			next_char:
				mov ah,08h
				int 21h
				cmp al,[si]
				jnz try_again_label
				inc si
				mov ah,02h
				mov dl,'*'
				int 21h
				loop next_char
			jmp success_label
		
		try_again_label:
			disp wrong
			jmp next_trial
		
		limit_exceed_label:
			disp limit_exceed
			jmp end_it
		
		success_label:
			disp correct
			

		end_it:
			mov ah,4ch
			int 21h
	end start
