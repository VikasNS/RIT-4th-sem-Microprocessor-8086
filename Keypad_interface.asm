;In the program writen below by mohan sir,
keypad must have 3 rows and 8 columns.
But most said it had even more rows,But in case there are more rows you can just change the program easily for that many 
;rows by changing one specific register content which ill tell later.

In this program we have two ports,
pc->output port
pa->intput port

And the selections or requests are made through active high signal unlike that of elevator program.
In elevator for 2nd floor would be 1101 so we were checking for a zero.
In keypad it would be opposite and we would be searching for a one.

At the end of the program,
you need to have row and column values in memory,
and something called as scan code is to displayed on the moniter.

what is a scan code?

imagine we have a 3*3 keypad,

8 7 6
5 4 3
2 1 0

remember scan codes are calculated from right to left (I'm 100% sure about it) , and bottom to down(I'm not sure).
Scan codes are just a number assigned to a specific key,ie 4th key 5th key etc and (i hope it isn't the actual contents.)(Im 70% sure it isn't).

In the above 3*3 I have started to number keys from right to left and starting from bottom to top.
Remember the contents(it could be alphabets or operator or anything ) but those are different are different from the scan code(which just mentions the position
;of the perticular key) and it doent represent the contents.

The main program has 2 parts
1)get the row,column and scancode
2)convert scancode to ascii so that we can display it.

Starting with the first part:

>We have pc as the output port and pa as the input port.
>We select a perticular row by outputing it the port c
  ex: 1st row 0000 0001 (active high selection)
>Then from port a we input ,all the columns in first row.If any key was pressed in that specific row,our input(columns) will have 
atleast one active high signal representing that columns ex input(00000010) represents 2nd column.
  
  assume the key was pressed in 2nd row(starting from bottom) and 2nd column(starting from right),
  >>>we would fist output to pc row one(0000 0001) and then take the input from pa all the column values.As the key wasn't pressed
  in 1st row all the bits in input will be zero(0000 0000)(this signifies no key was pressed in that row)
  >>>next we left rotate what we had previously outputed and that will be (0000 0010) and output this,Thus we selected 2nd row,
  Now we take the input from port a,As the key was pressed from 2nd column are input will be 0000 0010.
  
  Thus you must understand 
  >We continuesly select rows (starting from bottom to top) by outputing to port c
  >After we select a perticular row,we take input from port a,This input represents the columns present in that row,
   And if any key was pressed in that row,the input we get will atleast contain one 1,reperesenting the column in which the key was pressed
   
  >Imagine we have 5 rows 
    >we start with row 1 ,if we dont find move to row 2 then go till row 5,
    >After that?Once we have covered all the rows?
    >We repeat it again
    >ie start from 1 til row 5
    >This will be hapennin very fast and infinitely.
   
   Now comming to the scan code,
   >In the example keypad i showed above,there were 3 rows and 3 columns
   >Now im calculating scan code,first i will select row by outputing to port c then take the input from port a,But unfortuantily all the values 
   are zero signifying that key was not present in that row.Now what happens to scan code?
  >Initially scan code will be zero,if we dont find in a row we increment by the number of columns,ie it will be 0+3 = 3, and coninue will the remaining rows
  >You might be thinking this would only hold good if the key being pressed was only the leftmost key as it would only take values 0,3,6.
  >The answer is will will later fine tune it
  ex: if the key being pressed was in 2nd row and 2nd column
  then as out key isnt in 1st row,we would increment scan code by 3,so temporarily our scan code is 3.
  later in 2nd row we detect the key stoke,ie in 2nd columns (0000 0010)
  Now what i will do is i will start right rotating this , if i dont find a 0 i will increment scan code by 1
  so in my first attempt i fail,so 3+1 = 4 in my second attempt i find a 1,so i stop.
  So that 2nd row 2nd column key was 4th key.
  Thus we got our key as the 4th key.
  >Remeber we use the same method to caculate the column number also
  
    
>>2nd part
converting scan code in hexadecimal to ascii equivalent to print on screen

imagine we have 8*4 keypad


1f 1f1e 1d 1c 1b 1a 19
18 17 16 15 14 13 12 11
f  e  d  c  b  a  9  8
7  6  5  4  3  2  1  0

So we would have any of this hexadecimal code obatined after all this step
now lets take the worst case and find how to display it.
take 1f.
if 1fth key was pressed we have to display 1f on the moniter.

1f=0001 1111

first we copy it to some register say al
al=0001 1111
now we shift it right that will be 0000 0001
so we were able to isolate the left digit ,
now we will add 30h to get ascii equivalent and display it using 02h interupt

now about the second digit

1f=0001 1111

we mask the left 4 bits
ie and bl,0f
hoping that it was stored in bl
now bl will have 0000 1111


so we have isolated second digit
>>>>>Here the important thing to display alpahbets we need to add first 30h and aslo 7h,(Take a look at the ascii table there is 7 blocks gap betwee 9 and a)

So if its between 0 and 9 we add 30h and display
if its a to f we add 30h and then 7h also

Now lets go to program















assume cs:code,ds:data
data segment
       pa equ 44A0h
       pb equ 44A1h
       pc equ 44A2h
       cr equ 44A3h
       rowval db ?
       colval db ?
       scode db ?
data ends
code segment
start:
       mov ax,data
       mov ds,ax
       mov dx,cr
       mov al,90h (port c output port a input)
       out dx,al
try_again:        (This label will be repeated infinite times untill a key stroke is detected)
       mov bl,01h ;to select row
       mov bh,03h ;To check if we have executed the loop 3(3 rows) times(we decrement each time and if it turn zero we end the inner loop)
                  ;so this also represents no of rows,so if your device has 6 rows change this to 6
       mov cl,00h ;To keep track of scan code
       mov ah,01h ;to keep track of row number(He has started with row naming from 1 but later he changes to staring from 0 for columns
                  ;You should follow one way,start with 1 or 0 ie:you can have ah as 0 aslo but maintian uniformity)
next_row:
       mov dx,pc 
       mov al,bl (bl contains the row we want to select)
       out dx,al (we select that row)
       
       mov dx,pa 
       in al,dx  (For that corresponding row,we take the input,ie representing the columns in that row)
        
       cmp al,00h (if all are zeros it means key wasn't pressed in that row so we move onto next row)
       jne calculate (if its not equal to zero,it means atleast one of the bit is 1,representing a key stoke so we move on to finding row and column)
       add cl,08h (we have 8 columns , so if we dont find it a specific row,we increment by 8)
       inc ah (we will increment ah(represents row) hoping to find in next row) 
       shl bl,01 (we left rotate by 1,to select next row)
       dec bh     (We decrement bh)
       jnz next_row (If its not zero , we would still have some rows to check so continue checking next row)
       jmp try_again (if bh was zero,we would come here and we would repeat everthing again starting from row 1)
calculate:
       mov rowval,ah  (ah contains the row value,we move it to ah)
       mov ah,00h     (we will use ah somewhere else so we give it 00,we will use to count the column)
;to find the column
rot_again:
       ror al,01 (if we find 1,represents we found that column in which key was pressed so we move to other calculations)
       jc next
       inc ah     (if we didnt get a column we increment ah hoping to get a keystrike in next column)
       inc cl     (We also increment scan code)
       jmp rot_again (we continue with the next column)
       
       
       
;After all this steps we know row number,column nuber and scan code       
next:
       mov scode,cl 
       mov colval,ah
       
       mov al,cl ;we move scan code to al
       call disp
       mov ah,4ch
       int 21h
;above i explained by shifting right to get first digit and masking to get the second digit
;here they are shifting left and masking.
;you can esily relate
disp proc
       mov bl,al ; we make a copy of scancode onto bl
       mov cl,4
       shr al,cl we left shift ro get right value
       cmp al,09 we compare it with 9 ,if its greater we will add 7 else we will just add 30h
       jle add_30
       add al,07
add_30:
       add al,30h
       mov dl,al
       mov ah,02
       int 21h
       mov al,bl
       and al,0fh ;we mask the right digit to get left digit
       cmp al,09
       jle add_30_1
       add al,07
add_30_1:
       add al,30h
       mov dl,al
       mov ah,02
       int 21h
       ret
disp endp
code ends
end start
