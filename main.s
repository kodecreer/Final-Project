global _start

EXTERN getchar, getd

section .text
%include "std.s"
_start:
    
    call getd
    mov eax, EXIT
    mov ebx, 0;everything worked
    int 80h
