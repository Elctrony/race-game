                           .model small
.stack 64
.data
rightLimit equ 5
leftLimit equ 315
upLimit equ 2020
downLimit equ 160
;carwidth EQU 20d
trackwidth EQU 10d
tracklength EQU 30d
rectnum EQU 5
line1x DW 10D
line1y DW 10D
line2x DW 10D
line2y DW 10D
lastmove db 10 ; 0 top 
               ; 1 right 
               ; 2 down 
               ; 3 left
color DB 5h
fillColor db 7h
cnt db 0
; from 1 to 3 and from 2 to 4
.code
generateRandom PROC 
     mov si,200h
     looprand:  ;loop to slow down

        mov ah, 2ch
        int 21h
        mov ah, 0
        mov al, dl  ;;micro seconds?
        mov bl, 4
        div bl
        ;;; ah = rest               
        dec si
        cmp si,0
        jnz looprand      
        RET
generateRandom ENDP


; ||||||||||| Calculating DI ||||||||||||
CalcLine1Di PROC 
   mov ax,line1y
   mov bx,320d
   mul bx
   add ax,line1x
   mov di,ax 
   RET 
CalcLine1Di ENDP


CalcLine2Di PROC 
   mov ax,line2y
   mov bx,320d
   mul bx
   add ax,line2x
   mov di,ax  
   RET
CalcLine2Di ENDP

; ||||||||||| END DI ||||||||||||


DrawRightDown PROC 

call CalcLine1Di
mov bx,di
mov cx, trackwidth
mov al,color
rep STOSB

mov cx,trackwidth
mov al,color
loop3:
   mov es:[di],al
   add di,320d
loop loop3

mov cnt,trackwidth
dec cnt

momoloop:
    add bx,320d
    mov di,bx
    mov cx,trackwidth
    mov al,fillColor
    exa:
      mov es:[di],al
      inc di
      loop exa
    dec cnt
    cmp cnt,0
    jg momoloop

mov bx,trackwidth
add line1x,bx
add line1y,bx


RET
DrawRightDown ENDP


DrawDownRight PROC 

call CalcLine2Di
mov dx,di

mov cx,trackwidth
mov al,color
loop4:
   mov es:[di],al
   add di,320d
loop loop4

mov cx, trackwidth
mov al,color
rep STOSB

mov cnt,trackwidth
dec cnt

lab:
    add dx,1d
    mov di,dx
    mov cx,trackwidth
    mov al,fillColor
   loop5x:
      mov es:[di],al
      add di,320d
      loop loop5x
    dec cnt
    cmp cnt,0
    jne lab

mov bx,trackwidth
add line2x,bx
add line2y,bx

;mov lastmove,1
RET
DrawDownRight ENDP

DrawRight PROC 

jmp l23
l21:
    call DrawDownRight
    mov lastmove,1
    jmp l23
l22:   
    call DrawUpRight
    mov lastmove,1
    jmp l23


mov lastmove,1

l23:    
    cmp lastmove,2
       je l21
    cmp lastmove,0
       je l22


call CalcLine1Di
mov dx,di
mov cx,tracklength
mov al, color
rep STOSB

add line1x,tracklength

mov cnt,trackwidth
dec cnt
lll:
    add dx,320d
    mov di,dx
    mov cx,tracklength
    mov al,fillColor
    rep STOSB
    dec cnt
    cmp cnt,0
    jne lll


call CalcLine2Di
mov cx,tracklength
mov al,color
rep STOSB

add line2x,tracklength

mov lastmove,1

RET
DrawRight ENDP
;;;;;


DrawDown PROC 


jmp l12
l11:
    call DrawRightDown
    mov lastmove,2

l12:    
   cmp lastmove,1
       je l11


call CalcLine1Di

mov cx,tracklength
mov al, color
loop1:
   mov es:[di],al
   add di,320d
loop loop1

add line1y,tracklength



call CalcLine2Di
mov dx,di
mov cx,tracklength
mov al,color
loop2:
   mov es:[di],al
   add di,320d
loop loop2

mov cnt,trackwidth
dec cnt
lxx:
    add dx,1d
    mov di,dx
    mov cx,tracklength
    mov al,fillColor
   loop2x:
      mov es:[di],al
      add di,320d
      loop loop2x
    dec cnt
    cmp cnt,0
    jne lxx

add line2y,tracklength

mov lastmove,2
RET
DrawDown ENDP



DrawUp PROC 

jmp l32
l31:
    call DrawRightUp
    mov lastmove,0

l32:    
   cmp lastmove,1
       je l31
call CalcLine1Di
mov dx,di
mov cx,tracklength
mov al, color
loop20:
   mov es:[di],al
   sub di,320d
loop loop20

mov cnt,trackwidth
dec cnt

lzz:
    add dx,1d
    mov di,dx
    mov cx,tracklength
    mov al,fillColor
   loop3x:
      mov es:[di],al
      sub di,320d
      loop loop3x
    dec cnt
    cmp cnt,0
    jne lzz

sub line1y,tracklength

call CalcLine2Di
mov cx,tracklength
mov al,color
loop21:
   mov es:[di],al
   sub di,320d
loop loop21

sub line2y,tracklength

mov lastmove,0
RET
DrawUp ENDP


DrawUpRight PROC 

call CalcLine1Di
mov dx,di
mov cx,trackwidth
mov al,color
loop110:
   mov es:[di],al
   sub di,320d
loop loop110
mov cx, trackwidth
mov al,color
rep STOSB

mov cnt,trackwidth
dec cnt

laa:
    add dx,1d
    mov di,dx
    mov cx,trackwidth
    mov al,fillColor
   loop4x:
      mov es:[di],al
      sub di,320d
      loop loop4x
    dec cnt
    cmp cnt,0
    jne laa


mov bx,trackwidth
add line1x,bx
sub line1y,bx

RET
DrawUpRight ENDP


DrawRightUp PROC 


call CalcLine2Di
mov dx,di
mov cx, trackwidth
mov al,color
rep STOSB

mov cx,trackwidth
mov al,color
loop120:
   mov es:[di],al
   sub di,320d
loop loop120

mov cnt,trackwidth
dec cnt

la1:
    sub dx,320d
    mov di,dx
    mov cx,trackwidth
    mov al,fillColor
    rep STOSB
    dec cnt
    cmp cnt,0
    jne la1

mov bx,trackwidth
add line2x,bx
sub line2y,bx

RET
DrawRightUp ENDP







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
;top outline border
mov di,1600d;row 5
mov al,2h
mov cx,320
rep STOSB
;bottom outline border
mov di,51200d;row 159
mov al,2h
mov cx,320
rep STOSB



mov line1x,15d
mov line1y,85d
mov line2x,15d
mov line2y,85d
add line2x,trackwidth

call DrawUp
call DrawRight
call DrawDown
call DrawRight
call DrawUp
call DrawRight
call DrawDown
call DrawDown

;call DrawRight



MAIN ENDP
END MAIN 