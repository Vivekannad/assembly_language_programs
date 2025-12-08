.model small
.stack 100h
.data
.code

main proc

; swap two numbers using stack

mov ah, 1
int 21h

push ax

mov ah, 1
int 21h

mov dl , al
mov ah, 2
int 21h

pop ax

mov dl, al
mov ah, 2
int 21h

mov ah, 4ch
int 21h

main endp
end main