.model small
.stack 64
.data
rightLimit equ 5
leftLimit equ 315
upLimit equ 20
downLimit equ 160
;carwidth EQU 20d
trackwidth EQU 20
rectnum EQU 5
line1x DW 10D
line1y DW 10D
line2x DW ? 
line2y DW ? 
cnt db ?
lastmove db ?  ; 0 top 
               ; 1 right 
               ; 2 down 
               ; 3 left
color DB 5h
fillColor db 7h
; from 1 to 3 and from 2 to 4
.code
generateRandom PROC FAR
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


CalcLine2Di PROC FAR
   mov ax,line2y
   mov bx,320d
   mul bx
   add ax,line2x
   mov di,ax  
   RET
CalcLine2Di ENDP

; ||||||||||| END DI ||||||||||||


DrawRightDown PROC FAR

call CalcLine1Di
mov cx, trackwidth
mov al,color
rep STOSB

mov cx,trackwidth
mov al,color
loop3:
   mov es:[di],al
   add di,320d
loop loop3

mov bx,trackwidth
add line1x,bx
add line1y,bx


RET
DrawRightDown ENDP


DrawDownRight PROC FAR

call CalcLine2Di


mov cx,trackwidth
mov al,color
loop4:
   mov es:[di],al
   add di,320d
loop loop4

mov cx, trackwidth
mov al,color
rep STOSB

mov bx,trackwidth
add line2x,bx
add line2y,bx

;mov lastmove,1
RET
DrawDownRight ENDP

DrawRight PROC FAR



call CalcLine1Di
mov dx,di
mov cx,50d
mov al, color
rep STOSB

mov cnt,19d
lll:
    add dx,320d
    mov di,dx
    mov cx,50d
    mov al,fillColor
    rep STOSB
    dec cnt
    cmp cnt,0
    jne lll


add line1x,50d

call CalcLine2Di
mov cx,50d
mov al,color
rep STOSB


add line2x,50d

mov lastmove,1

RET
DrawRight ENDP
;;;;;


DrawDown PROC FAR

cmp lastmove,1
   call DrawRightDown

call CalcLine1Di
mov cx,50d
mov al, color
loop1:
   mov es:[di],al
   add di,320d
loop loop1

add line1y,50d

call CalcLine2Di
mov cx,50d
mov al,color
loop2:
   mov es:[di],al
   add di,320d
loop loop2

add line2y,50d

mov lastmove,2
RET
DrawDown ENDP






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
mov line1y,15d
mov line2x,15d
mov line2y,15d
add line2y,trackwidth


call DrawRight

call DrawDown
call DrawRight
call DrawDown
;call DrawRightDown


MAIN ENDP
END MAIN 