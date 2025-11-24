.model small
.stack 100h        

.data

num1 db ?
num2 db ?

message1 db "Enter the operation:- +,-,*,/$"
first db "Enter the first value:- $"
second db "Enter the second value:- $"
answer db "The output is $"
sub_error_mess db "Num1 is lesser than num2 so can't subtract"
newline db 13,10,"$"

.code

main proc     

mov ax, @data
mov ds, ax

mov dx, offset first
mov ah, 9
int 21h

mov ah, 1
int 21h


mov num1 , al
sub num1, 48

mov  dx, offset newline
mov ah, 09h
int 21h



mov dx, offset second
mov ah, 9
int 21h

mov ah, 1
int 21h

mov num2, al
sub num2, 48

mov dx, offset newline
mov ah, 9
int 21h

mov dx, offset message1  
mov ah,9
int 21h

mov ah, 1
int 21h

cmp al, '+'
je addition

cmp al, '-'
je subtract

cmp al, "*"
je multiply

cmp al, "/"
je divide

mov ah, 4ch
int 21h

main endp

addition proc
     mov al, num1
     add al , num2
     add al, 48
     
     mov dl, al
     mov ah, 2
     int 21h
    
    
    mov ah, 4ch
    int 21h


   addition endp


subtract proc
     mov al, num1  
       
       
     cmp al, num2
     jl error1
    
 
     sub al , num2
     add al, 48
     
     mov dl, al
     mov ah, 2
     int 21h
    
    
    
    mov ah, 4ch
    int 21h
 
subtract endp


multiply proc
    mov al, num1
    mov bl, num2
    
    mul bl
    
    add al, 48
    
    mov dl, al
    mov ah, 2
    int 21h 
    
    
    mov ah, 4ch
    int 21h
    
multiply endp

divide proc
    
    
    mov al, num1
    mov ah, 0
    mov bl, num2
    
    div bl
    
    add al, 48
    
    mov dl, al
    mov ah, 2
    int 21h
    
    mov ah, 4ch
    int 21h
 
divide endp

 
error1 proc
    mov dx, offset sub_error_mess
    mov ah, 9
    int 21h
    
    mov ah, 4ch
    int 21h
error1 endp