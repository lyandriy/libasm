section .text

global ft_strdup
extern ft_strlen
extern malloc
extern ft_strcpy

ft_strdup:
    call ft_strlen  ;strlen rrecibe como argumento rdi y la longitud la devuelve en rax
    push rdi        ;mover rdi a stack
    mov rdi, rax    ;mover rax(la longitud a rdi, que es el argumento)
    call malloc     ;llamar a malloc que recibe el tamaño con el rdi y devuelve el puntero a memoria reservada en rax
    cmp rax, 0      ;comprobar que se ha reservado la memoria
    je ret_error    ;
    mov rdi, rax    ;mover el rax a rdi, eto mueve el puntero reservado a rdi
    pop rsi         ;mover lo del stack a rsi
    call ft_strcpy  ;llamar a strcpy que va a recibir como argumento rdi el destino y rsi como strcpy
    ret
ret_error:
    mov rax, -1
    ret
