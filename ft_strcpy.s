section .text

global ft_strcpy

ft_strcpy:
    mov rax, rdi
loop:
    mov al, byte [rsi]
    mov byte [rdi], al
    cmp al, 0
    je .end
    inc rsi
    inc rdi
    jmp loop
.end:
    ret