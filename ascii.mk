all: ascii.asm
	nasm -f elf64 -F dwarf -g -o ascii.o ascii.asm
	gcc -m64 -o ascii ascii.o
	./ascii
