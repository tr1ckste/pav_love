.386
include \masm32\include\masm32rt.inc

enterProc proto :DWORD, :DWORD, :DWORD, :DWORD
anyProc proto :DWORD, :DWORD, :DWORD, :DWORD

.data
    hInstance   dd ?
    usr_passwrd    db 20 dup (?)
    msg_title  equ "Лабораторна №2"
    msg_pass   equ "Пароль:"
	my_data db "ПIБ: Василiненко Нiкiта Максимович", 13, "Дата народження: 12.07.2001", 13,"Номер залiковки: 9301",0
    data1   equ "ПIБ: Василiненко Нiкiта Максимович"
    data2 equ "Дата народження: 12.07.2001"
	data3 equ "Номер залiковки: 9301"
	msg_wrong  equ "Неправильний пароль"
    pswd   db "%#1& -"
	key equ 54h
    psw_len    DWORD 6
	IDC_EDIT equ 1234
	IDC_DATA equ 1111

.code
    start:
		invoke GetModuleHandle, NULL
		mov hInstance, eax
        call first
        invoke ExitProcess, 0
		
	first PROC
        Dialog msg_title, "Helvetica", 20,    \
            WS_OVERLAPPED or WS_SYSMENU or DS_CENTER, \
            3,                                         \
            100, 300, 90, 50,                            \
            1024
    
        DlgStatic msg_pass, 1, 0, 5, 80, 8, IDC_DATA
        DlgEdit WS_BORDER or ES_WANTRETURN, 3, 20, 80, 9, IDC_EDIT
        DlgButton "Ввести", WS_TABSTOP, 30, 30, 25, 10, IDOK
        
        CallModalDialog hInstance, 0, enterProc, NULL
        ret
    first ENDP
	
	wrong PROC
        Dialog msg_title, "Helvetica", 20,\
            WS_OVERLAPPED or WS_SYSMENU or DS_CENTER,\
            1,\
            100, 300, 90, 50,\
            1024
    
        DlgStatic msg_wrong, 1, 0, 5, 80, 8, IDC_DATA
        
        CallModalDialog hInstance, 0, anyProc, NULL
        ret
    wrong ENDP
	
	right PROC
        Dialog msg_title, "Helvetica", 20,\
            WS_OVERLAPPED or WS_SYSMENU or DS_CENTER,\
            3,\
            80, 350, 130, 50,\
            1024
    
        DlgStatic data1, 1, 0, 15, 120, 8, IDC_DATA
		DlgStatic data2, 1, 0, 25, 100, 8, IDC_DATA
		DlgStatic data3, 1, 0, 5, 80, 8, IDC_DATA
        
        CallModalDialog hInstance, 0, anyProc, NULL
        ret
    right ENDP
	
	enterProc PROC hWin:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
		LOCAL count:DWORD
        .IF uMsg == WM_COMMAND
            .IF wParam == IDOK
				invoke GetDlgItemText, hWin, IDC_EDIT, ADDR usr_passwrd, 512
                mov ebx, 5
                compare:
					mov ah, pswd[ebx]
					mov al, usr_passwrd[ebx]
					xor al, key
					
					.IF ah != al
						jmp different
					.ENDIF

					dec ebx
					.IF ebx == 0
						jmp equal
					.ENDIF
                jmp compare
					
				equal:
					call right
					ret
				
				different:
					call wrong
					ret
			.ENDIF
		.ELSEIF uMsg == WM_CLOSE
            invoke EndDialog, hWin, 0
        .ENDIF
		xor eax, eax
		ret
	enterProc ENDP
	
	anyProc PROC hWin:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
		.IF uMsg == WM_COMMAND
			invoke EndDialog, hWin, 0
		.ELSEIF uMsg == WM_CLOSE
            invoke EndDialog, hWin, 0
        .ENDIF
		xor eax, eax
		ret
	anyProc ENDP
	
end start