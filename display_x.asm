.model small

.data
	screen_type db 03

	x_coordinate db 40
	y_coordinate db 12

	color db 8h
	no_times db 1
	charecter db 'X'


.code
	start:
		mov ax,@data
		mov ds,ax

		mov ah,00h
		mov al,screen_type
		int 10h

		mov ah,02h
		mov dl,x_coordinate
		mov dh,y_coordinate
		int 10h

		mov ah,09h
		mov al,charecter
		mov bl,color
		mov cl,no_times
		int 10h

		mov ah,07h
		int 21h

		mov ah,4ch
		int 21h
	end start
