.model tiny
.data
	START_MSG 	DB "‚¢¥¤iâì ¯ à®«ì, ¡ã¤ì « áª : $"
	ERROR_MSG	DB "¥¯à ¢¨«ì­¨© ¯ à®«ì.$"
	PASSWD		DB "pavlov"
	DATA 		DB "„€I ‘’“„…’€:", 10,
				   "IŒ'Ÿ - Š®¢ «¨è¨­ Ž. ž.", 10,
				   "„€’€ €Ž„†…Ÿ - 12.09.2001", 10,
				   "ƒ“€ - I-8410$"
	PASSWD_LEN  DB 6
	USR_INPUT	DB 32 DUP (?)
.code
	org		100h
.startup
	MAIN: 
  	; CLEARING SCREEN
	MOV 	AX, 03h
   	INT 	10h

    ; PRINTING START MESSAGE
    MOV 	AH, 09h
    MOV 	DX, offset START_MSG
    INT 	21h

    ; READING USER'S INPUT
    MOV		AH, 3Fh
    MOV		BX, 0
    MOV		CX, 32
    MOV		DX, offset USR_INPUT
    INT 	21h

    ; CHECKING LENGTH
    CMP 	AX, 8
    JNE		MAIN

    MOV 	DI, 0
    VALIDATION:
    ; COMPARING CHARACTERS
    MOV		BL, USR_INPUT[DI]
    MOV		BH, PASSWD[DI]
    CMP		BL, BH
    JNE		MAIN

    ; INCREASING COUNTER
	INC		DI
	CMP		DI, 6
	JB		VALIDATION

	MOV 	AH, 09h
    MOV 	DX, offset DATA
	INT 	21h 
    
    ; END PROCESS
    EXIT:
    MOV 	AH, 4Ch
	MOV 	AL, 0
    INT 	21h
END