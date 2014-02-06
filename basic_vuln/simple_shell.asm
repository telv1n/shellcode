; simple_shell.asm is an assembly file I created which contains basic shellcode. It makes a call to execve that executes /bin/sh, spawning a terminal.
; AUTHOR: Keith S.

section .data

section .text

global _start

_start:
; clear out registers being used
xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx
; move 11 into eax (call execve function, see "man execve" for arguments[written below])
; execve("/bin/sh", {"/bin/sh", NULL} NULL)
mov al, 11
;push a null byte onto the stack
push ebx
;push //bin/sh onto the stack (extra slash for the 8 bits needed for 2 pushes)
push 0x68732f6e	; hs/n
push 0x69622f2f ; ib//
mov ebx, esp
push ecx
push ebx
mov ecx, esp
; send interrupt to 0x80 to execute command in eax (execve)
int 0x80