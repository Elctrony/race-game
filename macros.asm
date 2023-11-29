ScrollUp macro 
     mov ah,6
     mov bh,07
     mov cx,0
     mov dx,184Fh
     int 10h
endm  
ScrollDown macro 
     mov ah,7
     mov bh,07
     mov cx,0
     mov dx,184Fh
     int 10h
endm 

