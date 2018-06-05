.model tiny
.code
	start:
		mov bh,00h
		mov bl,00h
		
		mov ah,02h
		mov cx,100
		next:
			mov al,bl
			aam
			add ax,3030h
			
			push ax   ;to prevent al from changing when int 21h is called
			
			mov dl,ah
			mov ah,02h
			int 21h
			
		    	pop ax
			
			mov dl,al
			mov ah,02h
			int 21h
			
			mov dl," "
			int 21h
			
			inc bl	
			loop next
		mov ah,4ch
		int 21h
		

		
	end start
