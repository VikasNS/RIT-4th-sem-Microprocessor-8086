assume cs:code,ds:data

data segment
	pa equ 20a1h
	pb equ 20a2h
	pc equ 20a3h
	pd equ 20a4h
data ends

code segment
start:

	mov ax,data	
	mov ds,ax
	
	mov al,82h
	mov dx,cr
	out dx,al

	mov dx,pa
	mov al,00h ;to clear previous requests
	out dx,al

	mov al,0f0h ;enable request service
	out dx,al


	mov dx,pb
	scan:
		in al,dx
		and al,0fh
		cmp al,0fh ;if there is no request right nibble will be 1111
		je scan

	mov cx,01

	next_floor:
		ror al,1
		jnc got_it
		add cx,03
		jmp next_floor

	got_it:
		mov al,f0h	;f because it helps us to be in the current request,ie: doesnt turn of the request LED
		mov dx,pa

		move_up:
			add al,1
			out dx,al
			call delay
			loop move_up

		dec al
		and al,0fh ;0 to turn of the request LED
		
		call delay
		call delay
		
		move_down:
			out dx,al
			call delay
			dec al
			cmp al,00
			jne move_down

	mov ah,4ch
	int 21h
	
	delay proc
		mov si,20ffh
		
		fill_di:
			mov di,0ffffh
		dec_:
			dec di
			jnz di
		dec si
		jnz fill_di
		ret
		delay endp
			

code ends
end start
