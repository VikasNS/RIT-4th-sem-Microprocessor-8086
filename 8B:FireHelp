assume cs:code,ds:data
data segment

    pa equ 20a0h
    pb equ 20a1h
    pc equ 20a2h
    cr equ 20a3h
    
    fire db 71h,09fh,0f5h,061h
    help db 0d1h,061h,0e3h,031h
    
    data ends
code segment
    start:
    mov ax,data
    mov ds,ax
    
    mov dx,cr
    mov al,80h
    out dx,al
    
    rpt:
    
    mov cx,04
    lea si,fire
    
    next:
    mov al,[si]
    call disp
    inc si
    loop next
    
    call delay
    
    mov cx,04d
    lea si,help
    
    next1:
    mov al,[si]
    call disp
    inc si
    loop next
    
    call delay
    
    mov ah,06h
    mov dl,0ffh
    int 21h
    jz rpt
    
    mov ah,4ch 
    int 21h
    
    disp proc
        push cx
        mov cx,08
		
        nextbit:
        mov dx,pb
        out dx,al
        
		push ax
        
		mov dx,pc
        
		mov al,0ffh
        out dx,al
        
		mov al,00h
        out dx,al
        
		pop ax
        ror al,1
        
		loop nextbit
        
		pop cx
        ret
        disp endp
		
	delay proc
		push si
        mov si,02fffh
        l2:mov di,0ffffh
        l1:dec di
        jnz l1
        dec si
        jnz l2
		pop si
        ret
        delay endp
    code ends
end start
    
