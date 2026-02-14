# Contador ASM — x86_64 Linux

![Architecture](https://img.shields.io/badge/Architecture-x86__64-blue)
![Binary Format](https://img.shields.io/badge/Binary-ELF64-lightgrey)
![Assembler](https://img.shields.io/badge/Assembler-NASM-green)
![Linker](https://img.shields.io/badge/Linker-ld-orange)
![Platform](https://img.shields.io/badge/Platform-Linux-black)
![Status](https://img.shields.io/badge/Status-Stable-brightgreen)
![License](https://img.shields.io/badge/License-MIT-purple)

Projeto modular em Assembly (NASM) para Linux x86_64, utilizando chamadas diretas ao kernel via `syscall`, sem dependência de libc.

---

## Objetivo

Implementar um contador interativo que:

1. Lê um número decimal via `stdin`
2. Converte ASCII → inteiro
3. Incrementa o valor em 1
4. Converte inteiro → ASCII
5. Exibe o resultado via `stdout`

O foco é controle explícito de registradores, ABI e fluxo de execução.

---
### Responsabilidades

- `main.asm`  
  Orquestra o fluxo do programa.

- `io.asm`  
  Implementa abstrações mínimas para `read` e `write`.

- `convert.asm`  
  Contém `atoi` (ASCII → inteiro) e `itoa` (inteiro → ASCII).

- `constants.asm`  
  Define mensagens e buffers.

- `syscalls.inc`  
  Define números simbólicos das syscalls.

---

## Arquitetura Técnica

Arquitetura alvo: x86_64  
Sistema operacional: Linux  
Formato do executável: ELF64  
Ponto de entrada: `_start`  
Runtime C: inexistente  

Syscalls utilizadas:

- `SYS_READ`  (0)
- `SYS_WRITE` (1)
- `SYS_EXIT`  (60)

Todas as interações com o sistema são feitas via instrução `syscall`.

---

## Convenção de Chamadas

ABI utilizada: System V AMD64

Argumentos:
- `rdi`
- `rsi`
- `rdx`
- `rcx`
- `r8`
- `r9`

Retorno:
- `rax`

Caller-saved:
- `rax`, `rcx`, `rdx`, `rsi`, `rdi`, `r8–r11`

Este projeto não preserva registradores callee-saved, pois não há interoperabilidade com código externo.

---

## Fluxo de Execução---

## Algoritmos

### ASCII → Inteiro (`atoi`)

Para cada caractere:
- Subtrai `'0'`
- Multiplica acumulador por 10
- Soma o dígito

Complexidade: O(n)

### Inteiro → ASCII (`itoa`)

- Divide sucessivamente por 10
- Armazena restos na pilha
- Reverte ordem ao desempilhar

Complexidade: O(log₁₀ n)

---

## Compilação

### Manual

```bash
nasm -f elf64 src/main.asm -o main.o
nasm -f elf64 src/io.asm -o io.o
nasm -f elf64 src/convert.asm -o convert.o
nasm -f elf64 src/constants.asm -o constants.o
ld main.o io.o convert.o constants.o -o contador