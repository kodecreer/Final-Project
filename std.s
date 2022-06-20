

section .data
    ecxtemp dd 0

section .bss
cin:
    resb 1
getline:
    resb 1024
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
;ecx: String to print, 
;edx: Length of string
getline:
    mov ecx, eax
    mov eax, 3
    mov ebx, 0
    mov edx, 1024
    ret 
getn:
    call getline
    ;store the string into data variable
    mov [num_str], ecx
    ;for each byte in the string
    ;we will move the memory at an address
    ;and get the character at a certain point. 
loopn:
    mov [temp], [ecx+i]
    mov eax, temp
    mov ebx, 2
    call print
    inc i
    jnz loopn
powern:
    imul
print:
    mov ecx, eax
    mov edx, ebx
    mov eax, 4
    mov ebx, 1
    ret 