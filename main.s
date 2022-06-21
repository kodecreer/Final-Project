global _start
EXTERN getn, generate_random_num, printn, print, 

section .data
    nl:
        db `\n`,0
    lnl equ $ - nl
    x: 
      dd 0
section .text
;%include "std.s"
%include "io.h"
_start:
    
    call getn
    mov ebx, 2
    call printn
    mov dword [x], ecx
    mov eax, nl
    mov ebx, lnl
    call print

    mov eax, EXIT
    mov ebx, 0;everything worked
    int 80h
