.model small
.data
num db 5 ;This program doesnt work for numbers greater than 5 as their factorial exceeds 8 bits,Tell the same to teacher if asked.
res db 1

.code
	start:
		mov ax,@data
		mov ds,ax
		mov al,num
		call factorial
		
		mov bl,res ;answer will be stored in bl register in HEXADECIMAL form.!

        mov ah,4ch
		int 21h

		factorial proc
			cmp al,1
			je lets_end
			push ax
			dec al
			call factorial
			pop ax
			mul res
			mov res,al
			lets_end:ret
			factorial endp 
			
		
	end start
