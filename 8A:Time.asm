assume cs:code

code segment
start:
		
		
		mov ah,2ch
		int 21h
		
		mov al,ch
		aam
		add ax,3030h
		mov bx,ax
		
		call display
		
		mov al,cl
		aam
		
		add ax,3030h
		mov bx,ax

		call display
		
		
		
		mov ah,4ch
		int 21h
		
		display proc
			
			mov dl,bh
			mov ah,02h
			int 21h
			
			mov dl,bl
			mov ah,02h
			int 21h
			ret
		display endp

code ends
end start
