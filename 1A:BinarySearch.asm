assume cs:code,ds:data

display macro msg
	lea dx,msg
	mov ah,09h
	int 21h
endm



data segment
	numbers db 1,2,3,4,5
	key db 7
	found db "Key was found$"
	didnt_find db "Key was not found$"
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	lea si,numbers
	mov di,si
	
	mov cl,key
	next_comp:
		mov ax,si
		mov bx,di
		add bx,ax 	
		shr bx,01 ;divide by 2
		
		cmp [bx],cl
		je found_
		jb chg_si
		ja chg_di
		
		
	chg_si:
		mov si,bx
		inc si
		jmp check
	
	chg_di:
		mov di,bx
		dec di
		jmp check
	
	check:
		cmp si,di
		jbe next_comp
		jmp didnt_find_
	
	found_:
		display found
		jmp end_it
		
	didnt_find_:
		display didnt_find
		jmp end_it
		
	end_it:
		mov ah,4ch
		int 21h

code ends
end start
