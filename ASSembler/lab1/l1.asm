.386
.model stdcall
option casemap: none

include /masm32/include/masm32rt.inc

.data?
	buff db 128 dup(?)
	buff_posD db 32 dup(?)
	buff_negD db 32 dup(?)
	buff_posE db 32 dup(?)
	buff_negE db 32 dup(?)
	buff_posF db 32 dup(?)
	buff_negF db 32 dup(?)

.data
    dialog_title DB "Lab 1", 0
	
	form db "Symbol = %d", 10, "+A = %d", 10, "-A  = %d", 10, "+B = %d", 10,
		"-B = %d", 10, "+C = %d", 10, "-C = %d", 10, "+D = %s", 10, "-D = %s", 10,
		"+E = %s", 10, "-E = %s", 10, "+F = %s", 10, "-F = %s",
		0
	
    symbol DD 3011200
    posA DD +30
    negA DD -30
    posB DD +3011
    negB DD -3011
    posC DD +30112001
    negC DD -30112001
	
    posD dq +0.003
    negD dq -0.003
    posE dq +0.323
    negE dq -0.323
    posF dq +3234.719
    negF dq -3234.719

.code
    Main:
	invoke FloatToStr2, posD, addr buff_posD
	invoke FloatToStr2, negD, addr buff_negD
	invoke FloatToStr2, posE, addr buff_posE
	invoke FloatToStr2, negE, addr buff_negE
	invoke FloatToStr2, posF, addr buff_posF
	invoke FloatToStr2, negF, addr buff_negF
	
	invoke wsprintf, addr buff, addr form, symbol,
		posA, negA, posB, negB, posC, negC, addr buff_posD,
		addr buff_negD, addr buff_posE, addr buff_negE,
		addr buff_posF, addr buff_negF
			
	invoke MessageBox, 0, addr buff, addr dialog_title, MB_OK
    invoke ExitProcess, 0
    end Main