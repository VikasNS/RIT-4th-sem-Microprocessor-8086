.model small
.data
num db 5
res db 1

.code
	start:
		mov ax,@data
		mov ds,ax
		mov al,num
		call factorial

		mov ah,4ch
		int 21h

		factorial proc
			cmp al,00
			je lets_end
			push ax
			dec al
			call factorial
			pop ax
			mul res
			mov res,al
			lets_end:ret
	end start
