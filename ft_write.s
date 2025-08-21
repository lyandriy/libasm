section .text

global ft_write

ft_write:
    mov rax, 1
    syscall
    cmp rax, 0
    jl ret_error
    ret
ret_error:

    mov rax, -1
    ret