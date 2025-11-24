.model small
.stack 100h
.data

name1 db "Vivek$"

.code

main proc           

mov ax, @data
mov ds, ax

mov si, offset name1
mov cx, 5

label:
mov dl,name1[si]
mov ah, 2
int 21h
inc si



loop label

mov ah, 4ch
int 21h


main endp
end main