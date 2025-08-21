section .text

global ft_strcmp

ft_strcmp:
loop:
    cmp byte [rdi], byte [rsi]
    jne end_loop
    inc rdi
    inc rsi
    jmp loop
end_loop:
    ret byte [rdi] - byte [rsi]
