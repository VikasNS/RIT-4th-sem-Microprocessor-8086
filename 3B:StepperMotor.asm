
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
    mov al,80h  ;1000 0000 signifying we are using this device for simple I/O with all the ports as output(Though we will only use port a)
    out dx,al   ;output the control information to control register
    
    mov cx,100d ;Each rotation cause a change in 1.8 degrees,So to get 180 degree rotation we loop 100 times.
    mov al,88h	;1000 1000 This input helps us to rotate the stepper motor by magnetizing the coils
    mov dx,pa	  ;Move the address of output port A to dx register
      
    rot:
    out dx,al	  ;Out put the value in AL to port A whose address is in DX register
    ror al,1	  ;rol al,1 for anti
    call delay	;If we dont call delay,the rotation will be so fast that the we cant see.
    loop rot
    
    mov ah,4ch
    int 21h
   
    delay proc
        mov si,02fffh
        l2:mov di,0ffffh
        l1:dec di
        jnz l1
        dec si
        jnz l2
        ret
        delay endp
    code ends
end start
