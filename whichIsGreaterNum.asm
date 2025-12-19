.model small
.stack 100h
.data
message1 db "Enter the numb1: $"
message2 db "Enter the numb2: $"
num1 db 0
num2 db 0       
message3 db "Num2 is greater than num1$"   
message4 db "Num1 is greater than num2$"

.code 
main proc
    
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    mov dx,offset message1
    int 21h
    
    
    mov ah,1
    int 21h  
    
    mov num1,al
    
    mov dl,10
    mov ah,2
    int 21h
    
    mov dl,13
    mov ah,2
    int 21h
    
     mov ah,9
    mov dx,offset message2
    int 21h   
    
     mov ah,1
    int 21h  
    
    mov num2,al 
    
     mov dl,10
    mov ah,2
    int 21h
    
    mov dl,13
    mov ah,2
    int 21h
    
    mov al,num2
    
    
     cmp al,num2
     JG numb2bigger
     
     cmp al ,num1
     jl numb1bigger
     
    numb2bigger:  
    mov dx , offset message3
    mov ah, 9
    int 21h   
    
     jmp end
    
     numb1bigger:  
    mov dx , offset message4
    mov ah, 9
    int 21h   
    
    jmp end
    
         
   
     end:
    mov ah, 4ch
    int 21h
   
main endp
end main