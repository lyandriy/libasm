section .text

global ft_strcpy

ft_strcpy:
    mov rax, rdi
loop:
    mov dl, byte [rsi]
    mov byte [rdi], dl
    cmp dl, 0
    je .end
    inc rsi
    inc rdi
    jmp loop
.end:
    ret