nasm -gdwarf -f elf32 std.s -o std.o
ld -m elf_i386 std.o -o std
