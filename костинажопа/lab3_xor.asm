    .386
    .model  flat, stdcall
    option  casemap :none       ; case sensitive
    include \masm32\include\windows.inc
    include \masm32\include\masm32.inc
    include \masm32\include\kernel32.inc
    include \masm32\include\user32.inc
    include \masm32\include\debug.inc
    includelib  \masm32\lib\user32.lib
    includelib  \masm32\lib\masm32.lib
    includelib  \masm32\lib\kernel32.lib
    includelib  \masm32\lib\debug.lib
    include \masm32\include\msvcrt.inc
    includelib  \masm32\lib\msvcrt.lib
    include \masm32\macros\macros.asm
	
    .data
    Matrix1   dw 101,34,11,-24,12,54,16,9,12,-19,72,1,-14,121,61,22
	tbuf    dw ?
	Matrix2 dw 16 dup(?)
	M equ 6
    fm  db '%d, ',0
	new db 10
    buf dd ?
    Output  dd ?
    Numbers dd ?
	
    .code
start:
	mov ebx, 0
	LIL:
	lea esi, Matrix1
    mov ecx, (tbuf-Matrix1)/2
	mov edi, 0
hiksta: lodsw
    movsx   eax, ax
    push    ecx
	.IF edi == 4
		invoke  crt_printf, ADDR new, eax
	.ENDIF
	.IF edi == 8
		invoke  crt_printf, ADDR new, eax
	.ENDIF
	.IF edi == 12
		invoke  crt_printf, ADDR new, eax
	.ENDIF
	.IF ebx == 1 
		.IF (edi >=0 && edi < 4)
			invoke crt_printf, ADDR fm, 0
		.ELSEIF (edi >= 5 && edi < 7)
			invoke crt_printf, ADDR fm, 0
		.ELSEIF (edi == 9 || edi == 10)
			invoke crt_printf, ADDR fm, 0
		.ELSEIF (edi == 12 || edi == 15)
			invoke crt_printf, ADDR fm, 0
		.ELSE
			invoke  crt_printf, ADDR fm, eax
		.ENDIF
	.ELSE
		invoke  crt_printf, ADDR fm, eax
	.ENDIF
    pop ecx
	inc edi
    dec cx
	jne hiksta

	inc ebx
	.IF ebx != 2
		invoke  crt_printf, ADDR new, eax
		invoke  crt_printf, ADDR new, eax
		jmp LIL
	.ENDIF
	invoke  crt__getch
    invoke  crt_exit,0
	
    end start