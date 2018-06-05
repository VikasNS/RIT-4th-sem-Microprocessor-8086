;swi 0x202 	;Check if one of the Buttons has been pressed.;
			;If its pressed (Left)r0=2 (right)r0=1 ro=0 if no button is pressed 
			
;swi 0x200 ;display contents of R0 register

;swi 0x206 ;clear display

;beq  label       ;branch if equal (Similar to jump if equal)
;bgt  label       ;branch if greater (Similar to jump if greater)
;ldr r5,=zero 	  ;load the address of memory location with the name zero onto the register r5 (Similar to LEA SI,zero)
;ldrb ro,[r5]     ;load contents(byte) in memory pointed by r5 onto r0 (Similar to MOV a,[b])

;b count  ;no condition is checked ,just jumps to count (Similar to JMP)
;bl count ;branch with link ie:the line next to this instruction will be stored in lr register and makes it easy to return back here

;subgt r4, r4, #1 ;Subtract 1 from r4 and store it back to r4 IF AND ONLY IF THE FIRST TERM IN PREVIOUS COMPARISION WAS GREATER THAN SECOND TERM






;TO CHECK IF ANY KEYWAS PRESSED,IF YES IDENTIFIES WHICH KEY WAS PRESSED AND CALL THE CORRESPONDING LABEL
wait: swi 0x202 	;Check if one of the Buttons has been pressed
       cmp r0, #0   ;If its pressed (Left)r0=2 (right)r0=1 ro=0 if no button is pressed 
       beq wait
       ldr r5, =zero ;Load staring address
       ldr r3, =F	 ;Load ending address	
       mov r1, #0 		
       cmp r0, #1 ;if ro=2(greater than 1) we need to do in reverse order
       bgt loop2
	   
;TO DISPLAY IN Correct ORDER
loop1: ldrb r0, [r5] 
          add r1, r1, #1
          cmp r1, #17
          beq end
          swi 0x200 ;display contents of R0 register
          add r5, r5, #1
          bl count ;branch with link
          b loop1
		  
;TO DISPLAY IN REVERSE ORDER
loop2: ldrb r0, [r3]
         add r1, r1, #1
         cmp r1, #17
         beq end
         swi 0x200 ;display contents of R0 register
         sub r3, r3, #1
         bl count
         b loop2
end: b wait


;TO CREATE DELAY
count: mov r4, #64000
count1: cmp r4, #0
           subgt r4, r4, #1
           bgt count1
           swi 0x206 ;clear display
           mov pc, lr
.data
zero: .byte 0b11111101
one:  .byte 0b01110000
two:  .byte 0b11011110
three:.byte 0b11111010
four: .byte 0b01110011
five: .byte 0b10111011
six:  .byte 0b10111111
seven:.byte 0b11110000
eight:.byte 0b11111111
nine: .byte 0b11111011
A: .byte 0b11100111
B: .byte 0b11101111
C: .byte 0b10001101
D: .byte 0b11101101
E: .byte 0b10001111
F: .byte 0b10000111
