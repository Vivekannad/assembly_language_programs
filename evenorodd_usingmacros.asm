print macro p1
    mov dx, offset p1
    mov ah, 9
    int 21h   
    
endm

newline macro
    mov dl, 13
    mov ah,2
    int 21h
    
    mov dl, 10
    mov ah, 2
    int 21h
endm

.model small
.stack 100h
.data
    inputMessage db "Enter a number:-$"  
    evenMessage db "This is a even number$"
    oddMessage db "This is a odd number$"

.code                                   
main proc
    mov ax, @data
    mov ds, ax
    
    print inputMessage
    
    mov ah, 1
    int 21h
    
    push ax     ; pushing into stack and preserving the value as newline macro manipulates ax register.
    
    newline ; printing new line
    
    pop ax  ; popping the preserved value
    
    sub al, 48
    
    
    

    mov ah, 0           
    
    mov bl, 2 ; we'll divide by two to consider which one is even or not
    
    div bl  ; it means al = al / bl
            ; after dividing, quotient will be in al and remainder will be in ah
            
    cmp ah,0
    je even
    
    jmp odd
    
    even:
    print evenMessage
    
    jmp end
    
    odd:
    print oddMessage
 
    
    end:
    mov ah, 4Ch
    int 21h
    
main endp
end main
