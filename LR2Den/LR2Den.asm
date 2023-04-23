varl equ 30h
varh equ 31h

org 00h
jmp main

org 30h
main:
	mov r0, #5 ;счетчик цикла
	mov varl, #0
	mov varh, #0
	mov dptr, #arr
	;вычислительный цикл
circle:
	mov a, r1
	movc a, @a+dptr
	jb acc.0, skip
	add a, varl
	mov varl, a
	mov a, #0
	add a, #0
	mov varh, a
skip:
	inc r1
	djnz r0, circle
sjmp $
;массив данных
arr: db 209, 78, 203, 251, 146, 225, 170, 91, 15, 92, 58, 55, 217, 39, 162, 23, 112, 8, 227, 200, 17, 116, 200, 64, 105
end
