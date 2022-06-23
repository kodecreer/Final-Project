; Kode creer © Jun 23, 2022
;This is the std library for basic helper functions that
;make the program a lot easier to product
;I did implement random numbers, but it was too buggy to 
;include the project
global getchar, print

section .data
    ecxtemp dd 0
section .bss
;the data to hold the character
cin:
    resb 1
;This is dummy bytes to hold extra values in the line to ignore
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
;Parameters:
;eax: String to print, 
;ebx: Length of string
;Return values: None
;This prints the values that are in eax with a specified length in ebx
print:
    mov ecx, eax
    mov edx, ebx
    mov eax, WRITE
    mov ebx, STDOUT
    int 80h
    ret 