# Compiler and flags
AS = nasm
LD = ld
CFLAGS = -f elf64

# Targets and dependencies
all: main

main: main.o extra.o
	$(LD) -o main main.o extra.o

main.o: main.asm
	$(AS) $(CFLAGS) -o main.o main.asm

extra.o: extra.asm
	$(AS) $(CFLAGS) -o extra.o extra.asm

clean:
	rm -f *.o main

