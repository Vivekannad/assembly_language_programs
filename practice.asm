.model small
.stack 100h
.data 

num1 db ? 
num2 db ?
result db ?
x dw 1
.code
main proc
    
    
     mov ax, @data
     mov ds, ax
     
     mov ah, 7
     int 21h
     
     mov num1, al
     
     mov ah, 1
     int 21h
     
     mov num2, al
     
     sub num1, 48
     sub num2, 48
     
     mov al, num1
     add al, num2
     mov result, al    
         
         
     add num1, 48
     mov dl, num1
     mov ah, 2
     int 21h
     
     add num2, 48
     mov dl, num2
     mov ah, 2
     int 21h
     
     
     add result , 48
     mov dl, result
     mov ah, 2
     int 21h
     
     mov dl, 13
     mov ah, 2
     int 21h
     
     mov dl, 10
     mov ah, 2
     int 21h
     
     
     mov cx, 10
     mov bl, 48
     label:
        mov dl, bl
        mov ah, 2
        int 21h
        
        inc bl
        
     
     loop label
     
     mov dl, 13
     mov ah, 2
     int 21h
     
     mov dl, 10
     mov ah, 2
     int 21h
     
     
     
     mov cx, 4
     loop1:
        mov bx, cx
        mov cx, x
        
        loop2:
        
        mov dl, '*'
        mov ah,2
        int 21h
        
        loop loop2
        
        mov dl, 13
        mov ah,2
        int 21h
        
        mov dl, 10
        mov ah,2
        int 21h
        
        inc x
        
        
        mov cx, bx       
               
        
     loop loop1 
     
     mov cx, 4
     
     loop3:
     mov bx, cx
     dec x
     mov cx, x
    
     
     loop4:
        mov dl, '*'
        mov ah,2
        int 21h
        
      loop loop4
      
      mov dl, 13
        mov ah,2
        int 21h
        
        mov dl, 10
        mov ah,2
        int 21h
        

        
        
        mov cx, bx    
    
      loop loop3
    
    mov ah, 4ch
    int 21h

main endp
end main



