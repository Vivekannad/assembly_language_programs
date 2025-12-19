.model small
.stack 100h
.data                      
sum db 0
arr db 1,2,3,4,5,6,7,8,9,10
divisor db 2
.code
main  proc                      
    
    mov ax , @data
    mov ds , ax         
    
    
    mov cx , 10
    mov si , offset arr
    
    label:    
    mov al , [si]
    mov ah, 0
    div divisor  ; ah = remainder al = quotient
    
    cmp ah , 0
    jne oddNumber
    
    jmp increament
    
    
      
    oddNumber:
    mov al , [si]
    add sum , al
    
    
    increament:
    inc si
    
    
    loop label 
        
    mov al , sum
    aam     ; ah = higher byte al = lower byter    
    
    mov dl , ah
    mov bl , al
    add dl , 48
    mov ah, 2
    int 21h
    
 
    mov dl , bl 
    add dl , 48
    mov ah, 2
    int 21h
    
      
    
    
    end:
    mov ah, 4ch
    int 21h
    
main endp
end main