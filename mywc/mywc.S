.equ FALSE, 0
.equ TRUE, 1
.equ EOF, -1
        
.section .rodata
	string:
        	.string "%7ld %7ld %7ld\n"

.section .data
	lLineCount:
        	.long 0
	lWordCount:
        	.long 0
        lCharCount:
        	.long 0
        iInWord:
        	.long FALSE

.section .bss
	iChar:
        	.skip 4

.section .text
        .globl main
        .type main,@function

main:
	while:
        	call getchar
        	movl %eax, iChar
        	cmpl $EOF, %eax
        	je endwhile

        	incl lCharCount

        	movl iChar, %edi
        	call isspace
        	cmpl $FALSE, %eax
        	je notspace

        	cmpl $FALSE, iInWord
        	je isnewline

        	incl lWordCount
	        movl $FALSE, iInWord
	notspace:
        	cmpl $FALSE, iInWord
        	je break 
        	movl $TRUE, iInWord
	break:
	isnewline:
        	cmpl $'\n', iChar
        	jne loop
        	incl lLineCount
	loop:
        	jmp while
	endwhile:
        	cmpl $FALSE, iInWord
        	je output
        	incl lWordCount
	outout:
        	movl $string, %edi
        	movl lLineCount, %esi
        	movl lWordCount, %edx
        	movl lCharCount, %ecx
        	movl $0, %eax
        	call printf

        	movl $0, %eax
        	ret
