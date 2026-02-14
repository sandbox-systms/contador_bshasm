section .text 
    global atoi
    global itoa

section .text
    global print 
    global read_input

print: 
    ; rsi = ponteiro
    ; rdx = tamanho (reforço novamente sobre evitar overflow do buffer)
    mov rax, sys_write     
    mov rdi, stdout 
    syscall 
    ret                         ; retorna para funcão de chamada 

read_input:
    ; rsi = buffer 
    ; rdx tamanho maximo 
    mov rax, sys_read  
    mov rdi, stdin
    syscall 
    ret 

; =======================================
;  este comando é para converter string para inteiro
; rsi = ponteiro para string
; =======================================