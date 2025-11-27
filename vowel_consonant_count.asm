
; printing string/array macro
macro stringPrint p1
    mov dx , offset p1
    mov ah, 9
    int 21h
    
endm
 
;printing number macro
macro digitPrint p1 ;
    mov dl , p1
    add dl, 30h
    mov ah, 2
    int 21h
    
endm

; apply aam in this macro and printing the number
macro applyAAM p1  
    mov al, p1
    aam    ; divides the al into ah and al if greater than 9
    
    push ax  ; pushing ax to preserve the value of al
    
    digitPrint ah ;printing ah(higher byte)
    
    pop ax  ;popping ax
    
    digitPrint al    ; printing al(lower byte)
    
endm
    

.model small
.stack 100h
.data 
inputMessage db "Enter the word:-$"
vowelMessage db "Vowels are:-$"
consonantMessage db "Consonants are:- $"
vowel db 0   ;vowel count variable
consonant db 0  ;consonant count variable                
newline db 13,10,'$'    ;newline variable

.code           
main proc
    
    ;algorithm
        ; take input from user 
        ; it should be of character type
        ; determine during the loop if the character is vowel or consonants
    
    mov ax, @data
    mov ds, ax
        
    ; printing input message    
    stringPrint inputMessage
    
    inputLoop:   ;inputLoop label defined

    
        mov ah, 1     ; taking input from user
        int 21h
        
        cmp al, 13     ; if user enters enter key, jump to print label
        je print
        
        cmp al, 'a'     ; if user enters 'a' , jump to isVowel label
        je isVowel
        
        cmp al, 'e'     ; if user enters 'e' , jump to isVowel label
        je isVowel 
        
        cmp al, 'i'     ; if user enters 'i' , jump to isVowel label
        je isVowel  
        
        cmp al, 'o'     ; if user enters 'o' , jump to isVowel label
        je isVowel  
        
        cmp al, 'u'     ; if user enters 'u' , jump to isVowel label
        je isVowel
        
        jmp isConsonant  ; jumps to isConsonant label                      
  
    
     
     isVowel:   ;isVowel label defined
     
         inc vowel   ; increase the vowel count variable
         jmp inputLoop  ; jump to inputLoop label
         
     isConsonant:
        inc consonant   ; increase the consonant count variable
        jmp inputLoop   ; jump to inputLoop label
         
         
     
     print:     ; print label defined
           
        ;printing new line   
        stringPrint newline
     
        ; printing vowel message
        stringPrint vowelMessage    
        
        ; printing vowel count
        applyAAM vowel                     
        
        ;printing new line   
        stringPrint newline
        
        ; printing consonants message
        stringPrint consonantMessage
        
        ; printing consonants count
        applyAAM consonant
        
        jmp end     ; jump to end to terminate the program
     
                   
    
    end:    ;end label defined
    mov ah, 4ch
    int 21h
    
    
main endp
end main