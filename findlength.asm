.model small
.stack 100h
.data
message db "Hello$"
.code

main proc
     mov ax, @data
     mov ds, ax
     
     mov si, offset message
     
     mov cx, 0
     
     current_loop:
     mov al, [si]
     cmp al, '$'
     je length_found
     
     inc cx
     inc si
     jmp current_loop
     
     
     length_found:
     add cx, 48
     mov dl, cl
     mov ah, 2
     int 21h
     
    
    
    
    mov ah, 4ch
    int 21h
    
endp main
end main