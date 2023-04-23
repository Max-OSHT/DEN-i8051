varl equ 30h
varh equ 31h
zl equ 32h
zh equ 33h
org 00h
jmp main

org 30h
main:
	mov r0, #5 ;счетчик цикла
	mov dptr, #arr
	;вычислительный цикл
circle:
	mov sp, #120
	mov a, r1
	movc a, @a+dptr
	jb acc.0, skip
	call subProc
skip:
	inc r1
	djnz r0, circle
	sjmp $
subProc:
	push acc
	push psw
	setb rs0  ;задаем второй банк РНО
	clr rs1
	pop psw
	pop acc
	;умножение
	mov b, #4
	mul ab
	mov varh, b
	mov varl, a
	;сложение
	clr c
	mov a, zl
	add a, varl
	mov zl, a
	mov a, zh
	addc a, varh
	mov zh, a
	ret

sjmp $
;массив данных
arr: db 209, 78, 203, 251, 146, 225, 170, 91, 15, 92, 58, 55, 217, 39, 162, 23, 112, 8, 227, 200, 17, 116, 200, 64, 105
end

