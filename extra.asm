SYS_READ equ 0
SYS_WRITE equ 1

STDIN equ 0
STDOUT equ 1
STDERR equ 2

section .data

section .bss
    char resb 1

section .text

; sys_exit
%macro exit 1
	mov rax, 60
	mov rdi, %1
	syscall
%endmacro


; prints a single character
%macro printChar 1
    mov rax, %1
    mov [char], al
    
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rdx, 1
    mov rsi, char
    syscall
%endmacro


; prints a null terminated string
%macro print 1
	mov rax, %1
	call _print
%endmacro


; prints a null terminated string followed by a newline
%macro println 1
    mov rax, %1
    call _print

    printChar 10
%endmacro


; prints a digit
%macro printDigit 1
	; move into rsi ascii value of input
	mov rax, 48
	add rax, %1

    push rax
    mov rsi, rsp

	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rdx, 1
	syscall

    ; restore stack
    add rsp, 8
%endmacro


%macro printInt 1
    mov rax, %1
    call _printInt
%endmacro


; prints a null terminated string, argument in rax
_print:
	; holds the length of string
	mov rdx, 0
	.loop:
		; end if null byte
		cmp byte [rax], 0
		je .end
		
		; move to next byte
		inc rax
		; inc the length
		inc rdx
		
		jmp .loop
	.end:
		; mov rax to start of string
		sub rax, rdx

		mov rsi, rax
		mov rax, SYS_WRITE
		mov rdi, STDOUT
		syscall
		ret


; prints the integer stored in rax
_printInt:
    
    mov rbx, 10

    ; stores the length of integer
	mov r8, 0

	.loop:
		inc r8

		; rax = rax // 10
		; rdx = rax % 10
		mov rdx, 0
		div rbx

		; push current digit onto the stack
		push rdx

		; if quotient is not 0, continue the loop
		cmp rax, 0
		jne .loop

	.printLoop:
        pop rbx

		printDigit rbx

		dec r8
		jnz .printLoop

	ret

