%include "extra.asm"


section .data
    greet db "Hello, World!",0

section .bss

section .text
	global _start


_start:
    println greet
    exit 0

