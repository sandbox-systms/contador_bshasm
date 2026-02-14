%include "/include/syscalls.inc"

section .text
    global print
    global read_input

print:
    ; rsi: ponteiro para a string a ser impressa
    ; rdx: comprimento da string
    mov rax, sys_write
    mov rdi, sdtout
    syscall
    ret

read_input:
    ; rsi: ponteiro para o buffer onde a entrada será armazenada
    ; rdx: tamanho máximo da entrada (reforçando a importância de evitar overflow)
    mov rax, sys_read
    mov rdi, sdtin
    syscall
    ret