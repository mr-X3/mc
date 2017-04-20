%macro write 2			;common macro for input/output
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro
  
section .data
	
 bemsg db 10,13,"before execution",0ah
 belen equ $-bemsg

; smsg db 10,13," block",0ah
; slen equ $-smsg

 ;dmsg db 10,13,"destination block",0ah
; dlen equ $-dmsg

 aemsg db 10,13,"after execution",0ah
 aelen equ $-aemsg

 spmsg db " "
 splen equ $-spmsg
 
sdb db 23h,45h,0Ah,07h,55h,00h,00h,00h,00h,00h
 sb db 01h,02h,43h,84h,55h
 ddb db 00h,00h,00h,00h,00h
 cnt equ 5
 lcnt equ 0Ah

section .bss
num resb 1

section .text
global _start
_start:

write bemsg,belen
;================DISPLAY BLOCK BEFORE EXECUTION===================
;write smsg,slen
mov r9,sdb
mov ebp,lcnt
call dispblk


;===========DATA TRANSFER FROM SOURCE BLOCK TO DESTINATION BLOCK=============
mov esi,sdb+4
mov edi,sdb+9
mov ebp,cnt

loop: 
mov al,[esi]
mov [edi],al
dec esi
dec edi
dec ebp
jnz loop


write aemsg,aelen
;================DISPLAY BLOCK BEFORE EXECUTION===================
;write smsg,slen
mov r9,sdb
mov ebp,lcnt
call dispblk

mov rax,60
mov rdi,0
syscall


;===============PROCEDURE TO DISPLAY BLOCK==============
dispblk: 

l: 
call display
write spmsg,splen
inc r9
dec bp
jnz l
ret

;============PROCEDURE TO DISPALY NUMBER===============
display :
	mov r8,num
	mov bl,00
	mov cx,02
	mov rdi,r9
	mov bl,[rdi]

lo3 :
	
	rol bl,4
	mov al,bl
	AND al,0Fh
	cmp al,09h
	jbe l4
	add al,07h

l4 :	
	add al,30h
	mov [r8],al
	inc edi
	inc r8
	dec cx
	jnz lo3
        write num,02
	ret

                                     	
;before execution
;23 45 0A 07 55 00 00 00 00 00 

;after execution
;23 45 0A 07 55 23 45 0A 07 55 

	 		
