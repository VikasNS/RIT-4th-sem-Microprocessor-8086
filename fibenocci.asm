.model small

.data
	fib db 10 dup(?)
	n dw 10

.code
	start:
		mov ax,@data
		mov ds,ax

		mov cx,n
		sub cx,2
		
		mov ax,0
		mov bx,1
		
		lea si,fib
		mov [si],ax
		inc si
		mov [si],bx
		inc si
		
		next:
			add ax,bx
			mov [si],ax
			inc si
			xchg ax,bx
			loop next

		mov ah,4ch
		int 21h
	end start
