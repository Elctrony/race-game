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

GenerteRnd macro
    MOV AH, 00h      
    INT 1AH            
    mov  ax, dx
    xor  dx, dx
    mov  cx, 10    
    div  cx      
    add  dl, '0'  
    mov ah, 2h   
    int 21h   
endm
