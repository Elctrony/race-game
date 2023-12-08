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



Drawhorizontalpath MACRO ind1,ind3,col
     mov bx,ind1
     mov dx,ind3
     add dx,1d
     mov al,col
     repeat:
     mov di,bx
     mov cx,trackwidth
     loop1:
     stosb
     add di,319d
     loop loop1
     add bx,1d
     cmp dx,bx
     JNE repeat
ENDM Drawhorizontalpath
//////
Drawverticalpath MACRO ind1,ind3,col
     mov bx,ind1
     mov dx,ind3
     add dx,320d
     mov al,col
     repeat:
     mov cx,trackwidth
     mov di,bx
     rep stosb
     add bx,320d
     cmp dx,bx
     JNE repeat
ENDM Drawverticalpath

