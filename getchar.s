section .data
ecxtemp:
    dd 0
section .bss
cin:
    resb 1
dummy:
    resb 100
section .text
;To make the program more readable we will add this
;file of Enumerations
%include "io.h"

;parameters: There is none
;return value: 
;al will be the value in a comparable value for characters
;ecx will be the value in a comparable for strings but contains jus the one character
;eax will have the lenght entered but it doesn't matter really since we are writing for just one charcter
getchar:
    ;Cin will be the input being recieved
    ;There is no parameters needed
    mov ecx, cin
    mov eax, READ
    mov ebx, STDIN
    mov edx, 2
    int 80h
    
    ;This is for when someone decides to be a dummy
    ;and enter more than one character
    cmp byte[ecx + eax -1], 10
    jz good_read
    ;store it into a temp
    mov [ecxtemp], ecx
    ;;;;;;;;;;;;;;;;;;;;;;
    mov ecx, dummy
    mov edx, 100
    mov eax, READ
    mov ebx, STDIN
    int 80h
    mov ecx, [ecxtemp]
    jmp good_read
good_read:
    ;moving ecx to al to make char comparisons
    mov al, byte [cin]
    ret