.model small
.stack 100h
.data                      
number db 4
mulResult db 1
.code
main  proc                      
    
    mov ax , @data
    mov ds , ax         
    
    mov al , mulResult 
    mov ah, 0
           
    loop1:
    
    mul number
    
    dec number  
    
    mov bl , number
    
    cmp bl , 1
    je print
      

    
    jmp loop1
    
     
    print:
    aam
    
    mov dl , ah
    mov bl , al
    add dl , 48
    mov ah, 2
    int 21h
    
    mov dl, bl
    add dl , 48
    mov ah, 2
    int 21h
   
    
    
    end:
    mov ah, 4ch
    int 21h
    
main endp
end main