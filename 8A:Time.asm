assume cs:code,ds:data
display macro time
	mov cl,4
	mov al,time
	mov ah,00h
	shl ax,cl
	shr al,cl
	
	add ax,3030h
	
	push ax
	
	mov dl,ah
	mov ah,02h
	int 21h
	
	pop ax
	
	mov ah,02h
	mov dl,al
	int 21h
endm



data segment
hour db ?
min db ?
data ends

code segment
start:
	
	mov ax,data
	mov ds,ax
	
	mov ah,2ch
	int 21h
	
	mov hour,ch
	mov min,cl
	
	call adjust	
	display hour
	display min
	
	mov ah,4ch
	int 21h
	


adjust proc 

	mov cl,hour
	mov ch,00h
	next1:
	add al,01h
	daa
	loop next1
	mov hour,al

	mov al,0h
	mov cl,min
	mov ch,00h
	next2:
	add al,01h
	daa
	loop next2
	mov min,al
ret

adjust endp


	
code ends
end start
