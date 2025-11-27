.model small
.stack 100h
.data
inputMessage db "Enter password:-$"
notMatchedMessage db "Invalid Password$"    
matchedMessage db "Correct Password$"
pass db "2412362$" ; correct password
equal db 1      ; flag variable to determine if input password is correct or not
                ; 0 means incorrect 1 means correct
newline db 13,10,"$"
.code

main proc 
    
    mov ax, @data
    mov ds, ax
    
    mov dx, offset inputMessage ;printing input message
    
    mov ah, 9
    int 21h
    
    mov si, offset pass ; putting correct password's first char address into si
    
    inputLoop:
    
        mov ah, 8 ; taking input without echo
        int 21h
        
        push ax     ; pushing ax to preserve tha value of al
        
        mov dl, '*' ; printing * in place of actual input
        mov ah, 2
        int 21h
        
        pop ax  ;popping the ax
        
        cmp al, 13  ; jumps to print label if user presses enter
        je print
        
        cmp al , [si]   ; compares user input and character in the password
        jne notEqual    ; if not equal, then jump to notEqual label
        
        inc si  ; increase the index value 
        jmp inputLoop ; jumps to inputLoop label
        
        notEqual:   ; notEqual label defined
            mov al, equal   ; putting equal variable value in al.
            mov al, 0       ; changing the value to 0
            mov equal , al  ; putting al's value in equal variable
            inc si          ; increase the index value
            jmp inputLoop   ; jumps to inputLoop label
        
        print:       ; print label defined
            mov al, equal   ; moving equal variable's value to al.
            cmp al, 0       ; comparing if al == 0
            mov dl, offset newline  ; printing newlinr
            mov ah, 9
            int 21h
            je notEqualPrint    ; jump to notEqualPrint label if al == 0
            
            jmp equalPrint  ; jump to equalPrint label if al != 0
        
        notEqualPrint:  ; notEqualPrint label defined
        
            mov dx, offset notMatchedMessage    ; printing notMatchedMessage 
            mov ah, 9
            int 21h
            jmp end ;jump to end label
        
        equalPrint: ;equalPrint label defined
            mov dx, offset matchedMessage        ;printing matchedMessage
            mov ah, 9
            int 21h
            jmp end ;jump to end label
          
          
        end: ; end label defined
            mov ah, 4ch
            int 21h

main endp
end main