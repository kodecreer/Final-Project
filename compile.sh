nasm -gdwarf -f elf32 std.s -o std.o
nasm -gdwarf -f elf32 main.s -o main.o
ld -m elf_i386 main.o std.o -o main
