nasm -gdwarf -f elf32 main.s -o main.o
ld -g -m elf_i386 main.o -o main
