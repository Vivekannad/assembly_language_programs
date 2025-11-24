.model small
.stack 100h
.data
  array1 db 1,3,5,7
  array2 db 1 ,3,5,3
  not_equals_mess db "Not Equal$"
  equal_mess db "Both are equal$"

.code 
main proc
    
      mov ax, @data
      mov ds, ax
      
      mov si , offset array1
      mov di, offset array2
      
      mov cx, 4
      
      label:
      
      mov al, [si]
      
      cmp al, [di]
      jne not_equals
      
      inc si
      inc di
      
      
      loop label
      
      mov dx, offset equal_mess
      mov ah, 9
      int 21h
    
    mov ah, 4ch
    int 21h
    
    not_equals proc
      mov dl, offset not_equals_mess
      mov ah, 9
      int 21h
    
    
endp main
end main


    


