nasm -gdwarf -f elf32 getchar.s -o getchar.o
nasm -gdwarf -f elf32 main.s -o main.o
ld -m elf_i386 main.o getchar.o -o main
