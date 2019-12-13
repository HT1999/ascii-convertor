all: encrypt.asm
	nasm -f elf64 -F dwarf -g -o encrypt.o encrypt.asm
	gcc -m64 -o encrypt encrypt.o
	./encrypt
