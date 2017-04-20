%macro write 2
	mov edx,%1
	mov esi,%2
	mov edi,1
	mov eax,1
	syscall
%endmacro
%macro read 2
	mov edx,%1
	mov esi,%2
	mov edi,0
	mov eax,0
	syscall
%endmacro
%macro exit 0
	mov eax,60
	syscall
%endmacro
section .data
msg1 db 'Enter the four digit HEXADECIMAL number',10,13
len1 equ $-msg1
msg2 db 'The DECIMAL equivalent of hexadecimal entered is :',10,13
len2 equ $-msg1
msg4 db '',10,13
len4 equ $-msg4

section .bss
num1 resb 5
num2 resb 5



section .text
global _start
_start:

			write len1,msg1
			read 5,num1
	
			call accept
			mov ax,bx
			mov bx,0Ah
			mov cl,0
		l11: 	mov dx,0
			div bx
			push rdx
			inc cl
			cmp ax,0
			jne l11

			mov r9,num2
		l12: 	pop rdx
			add rdx,30h
			mov [r9],dx
			inc r9
			dec cl
			jnz l12
		write 5,num2
		write len4,msg4
exit
		
	accept: 
		mov ebx,0
		mov esi,num1
		mov ecx,4
	
	l2:	rol ebx,4
		mov al,[esi]
		cmp eax,39h
		jbe l1
		sub eax,07h
	
	l1: 	sub al,30h
		add ebx,eax
		inc esi
		dec ecx
		jnz l2
		ret
	
	
;ankit@ubuntu:~/Desktop/ma$ ./hb
;Enter the four digit HEXADECIMAL number
;000A
;10
;ankit@ubuntu:~/Desktop/ma$ ./hb
;Enter the four digit HEXADECIMAL number
;0010
;16

