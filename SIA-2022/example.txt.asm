.586
.model flat, stdcall
includelib libucrt.lib
includelib kernel32.lib
includelib "../Debug/GenLib.lib
ExitProcess PROTO:DWORD 
.stack 4096


 outnum PROTO : DWORD

 outstr PROTO : DWORD

 outsym PROTO : WORD

 concat PROTO : DWORD, : DWORD, : DWORD

 lenght PROTO : DWORD, : DWORD

 atoii  PROTO : DWORD,  : DWORD

.const
		newline byte 13, 10, 0
		LTRL1 sdword 1
		LTRL2 byte 'Len + 1:', 0
		LTRL3 byte 'concat:', 0
		LTRL4 byte 'X', 0
		LTRL5 sdword 9
		LTRL6 sdword -9
		LTRL7 byte 'Just', 0
		LTRL8 byte 'string', 0
		LTRL9 byte '80', 0
		LTRL10 byte 'from string in number:', 0
		LTRL11 sdword 2
		LTRL12 byte 'sdvig left:', 0
		LTRL13 sdword 23
		LTRL14 sdword 124
		LTRL15 sdword 3
		LTRL16 sdword 52
		LTRL17 byte ' ', 0
		LTRL18 byte ' after cycle ', 0
.data
		temp sdword ?
		buffer byte 256 dup(0)
		_minres sdword 0
		_standk sdword 0
		_standstr dword ?
		mainsymb word ?
		mainx sdword 0
		mainy sdword 0
		mainstrx dword ?
		mainstry dword ?
		mainstrz dword ?
		maine sdword 0
		mainresult sdword 0
		maint sdword 0
		mainasf sdword 0
		mainab sdword 0
		maind sdword 0
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
push LTRL1
pop ebx
pop eax
add eax, ebx
push eax

pop ebx
mov _standk, ebx


push offset LTRL2
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

push offset LTRL3
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


;----------- MAIN ------------
main PROC
mov al, LTRL4
mov mainsymb, ax

push mainsymb
call outsym

push offset newline
call outstr

push LTRL5

pop ebx
mov mainx, ebx

push LTRL6

pop ebx
mov mainy, ebx

mov mainstrx, offset LTRL7
mov mainstry, offset LTRL8
mov mainstrz, offset LTRL9

push offset LTRL10
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

push mainx
push LTRL1
pop ebx 
pop eax 
mov cl, bl 
shl eax, cl
push eax
push LTRL11
pop ebx 
pop eax 
mov cl, bl 
shl eax, cl
push eax

pop ebx
mov mainresult, ebx


push offset LTRL12
call outstr


push mainresult
call outnum

push offset newline
call outstr


push mainy
push mainx
call _min
push eax

pop ebx
mov maint, ebx


push LTRL14
push LTRL13
call _min
push eax

pop ebx
mov mainasf, ebx


push maint
call outnum


push mainasf
call outnum

push offset newline
call outstr

push LTRL15

pop ebx
mov mainab, ebx


pop ebx
mov maind, ebx

mov edx, mainab
cmp edx, LTRL16

jnz cycle2
jmp cyclenext2
cycle2:

push mainab
call outnum


push offset LTRL17
call outstr

push mainab
push LTRL11
pop ebx
pop eax
add eax, ebx
push eax
push LTRL11
pop ebx
pop eax
imul eax, ebx
push eax

pop ebx
mov mainab, ebx

mov edx, mainab
cmp edx, LTRL16

jnz cycle2
cyclenext2:

push offset LTRL18
call outstr


push mainab
call outnum

push offset newline
call outstr

push 0
call ExitProcess
main ENDP
end main
