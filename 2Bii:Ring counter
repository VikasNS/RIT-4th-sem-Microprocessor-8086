assume cs:code,ds:data
data segment
    pa equ 20a0h
    pb equ 20a1h
    pc equ 20a2h
    cr equ 20a3h
    data ends
code segment
    start:
    mov ax,data
    mov ds,ax
    
    mov dx,cr
    mov al,80h
    out dx,al
    
    mov al,01 ;0000 0001
     
    rpt:
    mov dx,pa 
    out dx,al ;we output al
    call delay ;call delay
    ror al,1 ;rotate it get the ring counter patter
	
	push ax ;We will be modifying ax value in the later stage of program,so to safegaurd the current ax value,we push it to stack
    
	;We need to prevent this from running infinitely,we do the same with the
	;below 3 lines of code which detects if any key in Keyboard was pressed
	;If pressed it will reset carry flag.Thus we will check if zero flag is set,if yes we will continue
	;If its reset we will terminate.
	
	mov ah,06h
    mov dl,0ffh
    int 21h
    
	
	pop ax ;We pop form stack to get the our previous ax value which we had pushed priviosly
    jz rpt ;We check zero flag,if its set,we continue,if its reset as we pressed any key in keyboard we stop and continue with next lines	
    
    mov ah,4ch
    int 21h
    
    delay proc
        mov si,02ffh
        l2:mov di,0ffffh
        l1:dec di
           jnz l1
           dec si
           jnz l2
           ret
    delay endp
    code ends
end start

        
    
    
