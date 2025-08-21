section .text

global ft_strcpy

ft_strcpy:
    mov rax, rdi
loop:
    mov bl, byte [rsi]
    mov byte [rdi], bl
    cmp bl, 0
    je end_loop
    inc rsi
    inc rdi
    jmp loop
end_loop:
    ret