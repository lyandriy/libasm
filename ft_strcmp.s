section .text

global ft_strcmp

ft_strcmp:
    xor rax, rax
loop:
    mov al, byte [rdi]
    mov dl, byte [rsi]
    cmp al, dl
    jne .end
    test al, al
    je .equal
    inc rdi
    inc rsi
    jmp loop
.end:
    movsx rax, al
    movsx rdx, dl
    sub rax, rdx
    ret
.equal:
    xor rax, rax
    ret