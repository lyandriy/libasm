section .text

global ft_strcmp

ft_strcmp:
    xor rax, rax
loop:
    mov bl, byte [rdi]
    mov cl, byte [rsi]
    cmp bl, cl
    jne end_loop
    cmp bl, 0
    je end_loop_equal
    inc rdi
    inc rsi
    jmp loop
end_loop:
    movsx r8, bl
    movsx r9, cl
    sub r8, r9
    mov rax, r8
end_loop_equal:
    ret