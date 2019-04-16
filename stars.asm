section .text
    global  _start

_start:
    mov     ebx,    0

line:
    inc     ebx         ; increment register ebx by 1
    mov     eax,    ebx ; mov the contents of ebx into eax, eax is the star counter for current line
    cmp     eax,    9   ; compare eax with total_lines
    jne     print_star  ; is eax != total_lines print the required stars on the current line
    jmp     exit        ; if not exit

print_star:             ; prints stars in a line followed by a new line
                        ; number of stars per line depend on the value of register eax
    push    eax         ; push eax onto the stac
    mov     eax,    star; move star literal to register eax for printing
    call    print       ; call print subroutine with the star chracter in eax
    pop     eax         ; pop eax off the stack
    dec     eax         ; decrement eax by 1
    jnz     print_star  ; if after decrement value is non-zero repeat the process
    push    eax         ; if the value becomes zero, push eax again onto the stack to preserve its value
    mov     eax,    LF  ; move new line character to eax
    call    print       ; call print subroutine
    pop     eax         ; pop off eax from stack
    jmp     line        ; jump to line label to start printing stars for next line

print:
    push    ecx         ; push onto the stack to preserve value
    push    ebx         ; push onto the stack to preserve value
    push    eax         ; push onto the stack to preserve value
    mov     edx,    1   ; number of bytes to print
    mov     ecx,    eax ; the character to print is passed on in eax, should be in ecx hence the move
    mov     ebx,    1   ; print to stdout
    mov     eax,    4   ; syscall for write
    int     80h         ; cal the kernel
    pop     eax         ; pop off and restore the original value
    pop     ebx         ; pop off and restore the original value
    pop     ecx         ; pop off and restore the original value
    ret                 ; pop off the return address and continue execution from there

exit:
    mov     ebx,    0   ; exit status code
    mov     eax,    1   ; sys_exit system call
    int     80h         ; call kernel

section .data
    star    db      '*', 0Ah    ; star literal followed by new line character
    LF      db      0Ah         ; new line character