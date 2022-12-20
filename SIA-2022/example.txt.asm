.586
.model flat, stdcall
includelib libucrt.lib
includelib kernel32.lib
includelib "../Debug/GenLib.lib
ExitProcess PROTO:DWORD 
.stack 4096


 outnum PROTO : DWORD

 outstr PROTO : DWORD

 outsym PROTO : DWORD

 concat PROTO : DWORD, : DWORD, : DWORD

 lenght PROTO : DWORD, : DWORD

 atoii  PROTO : DWORD,  : DWORD

.const
		newline byte 13, 10, 0
		LTRL1 sdword 1 
		LTRL2 sdword 0 
		LTRL3 byte 'lenght: ', 0
		LTRL4 byte 'concat:', 0
		LTRL5 byte 'I', 0
		LTRL6 sdword 9
		LTRL7 sdword -9
		LTRL8 byte 'Just', 0
		LTRL9 byte 'string', 0
		LTRL10 byte '80', 0
		LTRL11 byte 'attoi: ', 0
		LTRL12 sdword 3
		LTRL13 sdword 52
		LTRL14 byte ' ', 0
		LTRL15 sdword 2
		LTRL16 byte 'cycle end: ', 0
.data
		temp sdword ?
		buffer byte 256 dup(0)
		_minres sdword 0
		_minflag sdword 0
		_standk sdword 0
		_standstr dword ?
		_subnumresul sdword 0
		mainsymb word ?
		mainx sdword 0
		mainy sdword 0
		mainnas sdword 0
		mainstrx dword ?
		mainstry dword ?
		mainstrz dword ?
		maine sdword 0
		maint sdword 0
		mainads sdword 0
		mainab sdword 0
.code

;----------- _min ------------
_min PROC,
	_minx : sdword, _miny : sdword  
; --- save registers ---
push ebx
push edx
; ----------------------
mov edx, _minx
cmp edx, _miny

jl right1
jg wrong1
right1:
push _minx

pop ebx
mov _minres, ebx

jmp next1
wrong1:
push _miny

pop ebx
mov _minres, ebx

next1:
; --- restore registers ---
pop edx
pop ebx
; -------------------------
mov eax, _minres
ret
_min ENDP
;------------------------------


;----------- _stand ------------
_stand PROC,
	_standa : dword, _standb : dword  
; --- save registers ---
push ebx
push edx
; ----------------------

push _standa
push offset buffer
call lenght
push eax

pop ebx
mov _standk, ebx


push offset LTRL3
call outstr


push _standk
call outnum

push offset newline
call outstr


push _standb
push _standa
push offset buffer
call concat
mov _standstr, eax

push offset LTRL4
call outstr


push _standstr
call outstr

push offset newline
call outstr

; --- restore registers ---
pop edx
pop ebx
; -------------------------
ret
_stand ENDP
;------------------------------


;----------- _subnum ------------
_subnum PROC,
	_subnumaa : sdword, _subnumab : sdword  
; --- save registers ---
push ebx
push edx
; ----------------------
push _subnumaa
push _subnumab
pop ebx
pop eax
sub eax, ebx
push eax

pop ebx
mov _subnumresul, ebx

; --- restore registers ---
pop edx
pop ebx
; -------------------------
mov eax, _subnumresul
ret
_subnum ENDP
;------------------------------


;----------- MAIN ------------
main PROC
mov al, LTRL5
mov mainsymb, ax


push mainsymb
call outsym

push offset newline
call outstr

push LTRL6

pop ebx
mov mainx, ebx

push LTRL7

pop ebx
mov mainy, ebx


push mainy
push mainx
call _subnum
push eax

pop ebx
mov mainnas, ebx


push mainnas
call outnum

push offset newline
call outstr

mov mainstrx, offset LTRL8
mov mainstry, offset LTRL9
mov mainstrz, offset LTRL10

push offset LTRL11
call outstr


push mainstrz
push offset buffer
call atoii
push eax

pop ebx
mov maine, ebx


push maine
call outnum

push offset newline
call outstr


push mainstry
push mainstrx
call _stand


push mainy
push mainx
call _min
push eax

pop ebx
mov maint, ebx


push maint
call outnum

push offset newline
call outstr

push LTRL12

pop ebx
mov mainads, ebx

push LTRL12

pop ebx
mov mainab, ebx

mov edx, mainab
cmp edx, LTRL13

jnz cycle2
jmp cyclenext2
cycle2:

push mainab
call outnum


push offset LTRL14
call outstr

push mainab
push LTRL15
pop ebx
pop eax
add eax, ebx
push eax
push LTRL15
pop ebx
pop eax
imul eax, ebx
push eax

pop ebx
mov mainab, ebx

mov edx, mainab
cmp edx, LTRL13

jnz cycle2
cyclenext2:

push offset LTRL16
call outstr


push mainab
call outnum

push offset newline
call outstr

push 0
call ExitProcess
main ENDP
end main
