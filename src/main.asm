; =====================================
; Contador Simples em Assembly x86-64
; Este programa lê um número do usuário, incrementa esse número em 1 e exibe o resultado.
; =====================================

extern print                        ; função para imprimir mensagens na tela
extern read_input                   ; função para ler a entrada do usuário
extern atoi                         ; função para converter string para inteiro
extern itoa                         ; função para converter inteiro para string

extern msg_input                    ; mensagem de solicitação de entrada    
extern len_input                    ; comprimento da mensagem de solicitação de entrada    
extern msg_output                   ; mensagem de saída
extern len_output                   ; comprimento da mensagem de saída
extern buffer                       ; buffer para armazenar a entrada do usuário
extern result                       ; buffer para armazenar o resultado convertido de volta para string

section .text
    global _start

_start:
    ; imprimir mensagem inicial
    mov rsi, msg_input
    mov rdx, len_input
    call print
; ===============================================================
; tamanho máximo da entrada. Neste exemplo podemos notar que definimos o buffer com 32 bytes
; então é importante que o tamanho máximo da entrada seja igual ou menor que isso para evitar overflow. 
; Na cybersegurança, é crucial garantir que os buffers sejam adequadamente dimensionados para evitar vulnerabilidades de estouro de buffer. 
; Acertar o tamanho do buffer é uma prática fundamental para manter a segurança do sistema.
; ===============================================================
    ; ler a entrada do usuário
    mov rsi, buffer
    mov rdx, 32  
    call read_input

    ; converter a entrada de string para inteiro
    mov rsi, buffer
    call atoi

    ; increementar o resultado
    inc rax                                 ; incrementar o valor inteiro resultante da conversão

    ; converter o resultado de volta para string
    mov rdi, result
    call itoa                               ; converter o número inteiro incrementado de volta para string e armazenar em result

    ; imprimir a mensagem de saída
    mov rsi, msg_output
    mov rdx, len_output
    call print

    ; imprimir o resultado
    mov rsi, result
    mov rdx, rbx                            ; o tamanho da string resultante
    call print                              ; imprimir o resultado incrementado

    ; sair do programa
    mov rax, 60                             ; syscall: exit, pode usar a constante sys_exit definida em syscalls.inc
    xor rdi, rdi                            ; status: 0
    syscall