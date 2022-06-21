global _start
EXTERN generate_random_num, printn, print
section .text
;%include "std.s"
%include "io.h"
_start:
    
    call generate_random_num
    mov eax, ecx
    mov ebx, 1
    call printn
    int 80h

    mov eax, EXIT
    mov ebx, 0;everything worked
    int 80h
