global _start
EXTERN generate_random_num, printn
section .text
;%include "std.s"
_start:
    
    call generate_random_num
    mov eax, ecx
    mov ebx, 1
    call printn
    mov eax, EXIT
    mov ebx, 0;everything worked
    int 80h
