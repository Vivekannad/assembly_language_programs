.model small
.stack 100h
.data

array db 1,3,5,7,9
message db "Array Values:- $"


.code

main proc
    
    
    mov ax, @data
    mov ds, ax
    
    mov si, offset array
    mov cx, 5
    
    mov dx, offset message
    mov ah, 9
    int 21h
    
    label:    
          mov dl, array[si]
          add dl, 48
          mov ah, 2
          int 21h
          
          mov dx, 32
          mov ah, 2
          int 21h
          
          inc si 
    
    
    
    loop label
    
    mov ah, 4ch
    int 21h
    
    
endp main
end main