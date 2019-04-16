section .text
    global _start

_start:
    mov ecx, 0 ; initialize ecx to zero

increment:
    inc ecx ; increment number by 1
    push ecx ; place the incremented number on top of stack
    add ecx, 48 ; add ASCII '0' to convert it to a character

    mov [res], ecx ; this needs to be done (for some unknown reason)
    ; Update: this needs to be done as ecx should point to a memory address
    mov ecx, res

    call print ; call print subroutine and push the return address on top of stack
    call print_newline ; call print_newline subroutine and push the return address on top of stack
    call checkandincrement ; call checkandincrement subroutine and push the return address on top of stack

print:
    mov edx, 1 ; the bytes to be written
    mov ebx, 1 ; write to stdout
    mov eax, 4 ; syscall for write
    int 80h ; hello kernel
    ret ; return to the address at top of stack

print_newline:
    mov ecx, 0Ah ; place new line character on ecx
    mov [res], ecx ; needs to be done, (no idea why)
    ; Update: ecx should point to a memory location which should contain a string literal
    ; to be printed, hence this routine is necessary
    mov ecx, res ; move new line character to ecx
    call print ; print new line
    ret ; return back

checkandincrement:
    pop eax ; the address at top of the stack is the return address from this subroutine
    ; since we are checking and branching we don't need this address, hence pop it
    pop ecx ; this is the current value of counter
    cmp ecx, 9 ; performs subtraction of 9 from ecx
    jne increment ; if the result is not zero that is ecx != 9 jump to increment label

done:
    mov eax, 1 ; syscall for exit
    mov ebx, 0 ; return status code, exiting gracefully
    int 80h ; hi again kernel

section .data
    num db 4 ; if 9 is replaced by this it doesn't work, gotta figure why

section .bss
    res: resb 1