section .text

global ft_write
extern ___error

ft_write:
    mov rax, 1
    syscall
    cmp rax, 0
    jl .error
    ret
.error:
    neg rax
    mov rdi, rax
    call ___error
    mov [rax], rdi
    mov rax, -1
    ret