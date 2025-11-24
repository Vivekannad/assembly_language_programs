.model small
.stack 100h
.data
message db "Hello World$"

.code

main proc
     
     mov ax, @data
     mov ds, ax
     
     mov si, offset message
     mov cx, 11
     
     loop1:
        mov bx, [si]
        push bx 
        
        inc si
     
     
     loop loop1
     
     mov cx, 11
     
     loop2:
     
     pop bx
     mov dl, bl
     mov ah, 2
     int 21h 
     
     loop loop2
    
    mov ah, 4ch
    int 21h
    
endp main
end main