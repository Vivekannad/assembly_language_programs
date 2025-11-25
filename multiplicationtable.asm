macro newline:
    
mov dl, 13
mov ah, 2
int 21h

mov dl, 10
mov ah, 2
int 21h


    
endm

macro printFormat p1,p2
   
    mov dl , p1
    add dl, 30h ; converting into ASCII
    mov ah,2
    int 21h
    
    mov dl , '*'
    mov ah, 2
    int 21h
    
    mov al, p2  ; moving into al to apply aam
    aam
    add ah, 30h     ;converting into ASCII
    add al, 30h
    
    mov dl, ah  ; moving higher byte into dl

    push ax     ; pushing ax to preserve the value of al                                    
    mov ah, 2
    int 21h
    
    pop ax  ;popping ax
    mov dl, al   ; moving lower byte into dl

    mov ah, 2
    int 21h
    
    mov dl, '='
    mov ah, 2
    int 21h
    

    
endm 
    

.model small
.stack 100h 
.data
num db 2
times db 1

.code   
main proc
    
    mov ax, @data
    mov ds, ax
    
    mov cx, 10
    
    mulloop:
    
        mov al,  num
        mov bl, times
        
        mov ah, 0
        
        mul bl  ; al = al *  bl
        aam    ; AAM =  ASCII adjust after multiplication
        
        add al, 30h     ; converting into ASCII characters
        add ah, 30h
        
        push ax    ; preserving the value of ax and pushing into stack
        
        printFormat num,times
        
        pop ax  ;popping the ax which containe the mult result
        
        mov dl, ah
        push ax     ; pushing the ax to preserving the value of al which can be manipulated on next lines.
        mov ah,2
        int 21h  
        
        pop ax  ; popping ax
        
        mov dl,al
        mov ah,2
        int 21h
        
        inc times
        newline
    
    
    loop mulloop
    
    
    
    
    
    
    mov ah, 4ch
    int 21h
    
endp main
end main
