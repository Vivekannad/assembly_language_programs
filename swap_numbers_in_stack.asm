.model small
.stack 100h
.data

.code

main proc 
    
mov ax, 1
mov bx, 2

push ax
push bx

pop ax
add al, 48
mov dl, al
mov ah ,2
int 21h
pop bx
add bl, 48
mov dl, bl
mov ah, 2
int 21h
  
  mov ah, 4ch
  int 21h
  
main endp
end main