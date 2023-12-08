.model small
.stack 64
.data
carwidth EQU 20d
trackwidth EQU carwidth*3
rectnum EQU 5
index1 DW ? 
index2 DW ? 
points DW 3520d,50560d,3580d,3839d,22980d,25220d,25360d,25599d,44560d,50640d
kind DB '|','-','|','-','|'
color DB ?
; from 1 to 3 and from 2 to 4
.code
Drawhorizontalpath MACRO ind1,ind2,col
mov bx,ind1
mov dx,ind2
add dx,1d
mov al,col
repeat2:
mov di,bx
mov cx,trackwidth
loop2:
stosb
add di,319d
loop loop2
add bx,1d
cmp dx,bx
JNE repeat2
ENDM Drawhorizontalpath
;;;;;
Drawverticalpath MACRO ind1,ind2,col
mov bx,ind1
mov dx,ind2
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
;;;;;;
MAIN PROC FAR
mov ax,@data
mov ds,ax
mov ax,0003h;to clearscreen
int 10h
mov ax,0a000h;to graphics screen
mov es,ax
mov ax,0013h; 320*200 screen
int 10h
mov di,3200d;row 10
mov al,3h
mov cx,320
rep STOSB
mov di,50880d;row 159
mov al,3h
mov cx,320
rep STOSB
;generate path
; paint screen
mov bx,3520d
mov al,0Eh
repeat3:
mov cx,320
mov di,bx
rep stosb
add bx,320d
cmp bx,50880d
JNE repeat3
; draw path
LEA di,kind
LEA si,points
mov ah,rectnum
drawpath:
mov dx,[si]
mov index1,dx
add si,2d
mov dx,[si]
mov index2,dx
add si,2d
cmp ah,1d
JE finish
mov al,7h
jmp skip1
finish:
mov al,0fh
skip1:
mov color,al
mov al,[di]
add di,1d
push di
cmp al,'|'
JE vertical
Drawhorizontalpath index1,index2,color
jmp skip2 
vertical:
Drawverticalpath index1,index2,color
skip2:
pop di
dec ah
jnz drawpath


;mov ah,4ch;exit program
;int 21h
MAIN ENDP
END MAIN 