all: decrypt.asm
	nasm -f elf64 -F dwarf -g -o decrypt.o decrypt.asm
	gcc -m64 -o decrypt decrypt.o
	./decrypt
