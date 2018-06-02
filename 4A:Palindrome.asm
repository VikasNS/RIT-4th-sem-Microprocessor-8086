.model small

.data
	original db "tingrirgnit"
	len dw len-original
	reverse db 100 dup(?)
	yes db "Its a palindrome$"
	no db "Its not a palindrome$"

.code
	start:
		mov ax,@data
		mov ds,ax
		mov es,ax

		lea si,len
		dec si
		lea di,reverse
		mov cx,len

		copy:
			mov al,[si]
			mov [di],al
			dec si
			inc di
			loop copy

		lea si,original
		lea di,reverse
		mov cx,len
		cld
		rep cmpsb
		jz yes_
		lea dx,no
		jmp display
		yes_:
			lea dx,yes
		display:
			mov ah,09h
			int 21h

		mov ah,4ch
		int 21h
	end start
