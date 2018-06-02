assume cs:code,ds:data

data segment
    pa equ 20A0h
    pb equ 20A1h
    pc equ 20A2h
    cr equ 20A3h
    data ends
code segment
    start:
    mov ax,data
    mov ds,ax
    
    mov dx,cr   ;move control register address to dx register
    mov al,80h	;80 = 1000 0000 signifying we are using this device for simple I/O with all the ports as output(Though we will only use port a)
    out dx,al	  ;output the control information to control register
    
    mov cx,100d	 ;We load cx with 100 because we need to loop for 100 times later.
    mov al,00	   ;We initialze ah with 0
    mov dx,pa	   ;We load dx register with port A's address as we will output to this port later
    
    nxt:
    out dx,al 	;Outputs value in al to address in DX which contains adress of port A
    add al,1	  ;We increment al by one
    daa			    ;The contents of al after increment may not be in BCD form,so we call Decimal Adjust after Adition which adjust to BCD form
    call delay	;We call delay,If delay is not called the light's blink so fast that we cannot see the output
    loop nxt	  ;Loop nxt,first decremetns CX,checks if it is 0,if not jumps to nxt.
    
	
	  ;Previously we started with 0 and went upto 100
	  ;Below we start with 100 and go down till 0
	  ;Remember al allready has 100
	
    mov cx,100d	 
    nxt1:
    out dx,al	  ;Output al to address pointed by dx,which is port A
    sub al,1	  ;We decremet al
    das			    ;Adjust to get in proper form
	  call delay	;Call delay
    loop nxt1
    
    mov ah,4ch
    int 21h
    
	;This procedure contains two loops.This runs for some time,thus creating delay.
    delay proc
        mov si,02fffh
        l2:mov di,0fff
        l1:dec di
           jnz l1
           dec si
           jnz l2
		   ret     
    code ends
end start
    
