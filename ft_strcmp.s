section .text

global ft_strcmp

ft_strcmp:
    xor rax, rax
loop:
    mov cl, byte [rdi]
    mov dl, byte [rsi]
    cmp cl, dl
    jne .end
    test cl, cl
    je .equal
    inc rdi
    inc rsi
    jmp loop
.end:
    movsx rcx, cl
    movsx rdx, dl
    sub rcx, rdx
    mov rax, rcx
    ret
.equal:
    xor rax, rax
    ret