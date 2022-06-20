global _start

EXTERN getchar

section .text
%include "getchar.s"
_start:
    
    call getchar ;case when we enter y 

    mov eax, 1
    mov ebx, 0;everything worked
    int 80h
