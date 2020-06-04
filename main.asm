.model flat, stdcall
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include module.inc
include longop.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

option casemap :none

.data
	Caption db "n!" ,0
	Caption1 db "n! x n!" ,0
	Captiontest1 db "test N*N (11..11*11..11)" ,0
	Captiontest2 db "test N*32 (11..11*11..11)" ,0
	Captiontest3 db "test N*N (11..11*10..01)" ,0
	textBuf dd 40 dup(?)
	textBuf1 dd 40 dup(?)
	textBuftest1 dd 40 dup(?)
	textBuftest2 dd 40 dup(?)
	textBuftest3 dd 40 dup(?)

	var dd 5 dup(0)
	varbig dd 10 dup(0)
	x dd 62

	test1 dd 5 dup(4294967295)
	test1res dd 10 dup(0)

	test2 dd 5 dup(4294967295)

	test31 dd 5 dup(4294967295)
	test32 dd 1h, 0, 0, 0, 80000000h
	test3res dd 10 dup(0)

	
.code
	main:
	mov [var], 1
	@fact:
	
		push offset var
		push x
		call Mul_Nx32_LONGOP 
	
	dec x
	jne @fact
		

	push offset textBuf
	push offset var
	push 160
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textBuf, ADDR Caption, 0

	push offset var
	push offset var
	push offset varbig
	call Mul_NxN_LONGOP

	push offset textBuf1
	push offset varbig
	push 320
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textBuf1, ADDR Caption1, 0

	push offset test1
	push offset test1
	push offset test1res
	call Mul_NxN_LONGOP

	push offset textBuftest1
	push offset test1res
    push 320
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textBuftest1, ADDR Captiontest1, 0

	mov dword ptr [test2 + 16] , 0

	push offset test2
	push 4294967295
	call Mul_Nx32_LONGOP

	push offset textBuftest2
	push offset test2
	push 160
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textBuftest2, ADDR Captiontest2, 0

	push offset test31
	push offset test32
	push offset test3res
	call Mul_NxN_LONGOP

	push offset textBuftest3
	push offset test3res
	push 320
	call StrHex_MY

	invoke MessageBoxA, 0, ADDR textBuftest3, ADDR Captiontest3, 0
	invoke ExitProcess,0
end main

