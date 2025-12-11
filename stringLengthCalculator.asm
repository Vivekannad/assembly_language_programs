.model small
.stack 100h
.data
count db 0
.code
    main proc
        
        mov ax, @data
        mov ds , ax
        
        loop1:
        
        mov ah, 1
        int 21h
        
        cmp al, 13
        je printLength
        
        inc count
        
        jmp loop1
        
        printLength:
            mov al, count
            aam
            
            mov dl , ah
            push ax  
            add dl, 48
            mov ah, 2
            int 21h
            
            pop ax
            mov dl , al
            add dl, 48
            mov ah, 2
            int 21h
        
        
        mov ah, 4ch
        int 21h
        
    main endp
    end main