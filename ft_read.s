section .text

global ft_read

ft_read:
    mov rax, 0
    syscall
    cmp rax, 0
    jl ret_error
    ret
ret_error:
    mov rax, -1
    ret