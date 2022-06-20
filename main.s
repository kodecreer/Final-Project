global _start

EXTERN getchar

section .text
%include "std.s"
_start:
    
    call getchar ;case when we enter y 

    mov eax, EXIT
    mov ebx, 0;everything worked
    int 80h
