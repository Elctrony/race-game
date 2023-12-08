                       .MODEL SMALL
.DATA   
cnt db 50
.CODE 

;description
drawpixel PROC
       
    mov ah, 2ch
    int 21h    
    mov al, ch
    mov ah, 0    
    mov bl, 10 
    div bl  
    MOV DI,DX
    MOV ES:[DI],0CH 

    ret
drawpixel ENDP
MAIN PROC FAR
    mov ax, @data
    mov ds,ax 
    MOV AX,0A000h
    MOV ES,AX     
    MOV ax, 013h
    INT 10h   
    ;  mov ah, 2ch
    ; int 21h    
    ; mov al, ch
    ; mov ah, 0    
    ; mov bl, 10 
    ; div bl  
    ; MOV DI,DX
    ; MOV ES:[DI],0CH 


    l1: call drawpixel
    dec cnt
    cmp cnt,0
    jne l1
    
MAIN ENDP
END MAIN 