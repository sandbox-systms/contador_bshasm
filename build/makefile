asm=nasm 
ld=ld
asmflags=-f elf64 
src=src/main.asm src/io.asm src/convert.asm src/constantes.asm

all: 
	$(asm) $(asmflags) src/main.asm -o main.o 
	$(asm) $(asmflags) src/io.asm -o io.o
	$(asm) $(asmflags) src/convert.asm -o convert.o 
	$(asm) $(asmflags) src/constantes.asm -o constantes.o
	$(ld) $(asmflags) main.o io.o convert.o constantes.o -o contador_bshasm

clean: 
	rm -f *o contador_bshasm