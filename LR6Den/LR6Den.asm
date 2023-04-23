varQ equ 30h
varl equ 31h
varh equ 32h
zl equ 33h
zh equ 34h

org 00h
jmp main

org 03h
jmp input

org 13h
jmp formula

org 30h
main:
	mov dptr, #arr
	mov tcon, #5
	mov ie, #85h
	;активация
	mov p0, #0
 	mov p1, #0
  	mov p2, #0
   	mov p3, #0ffh

circle:
  	mov a, p3
   	anl a, #0f0h
    	add a, #0
    	jnz wheel
    	jmp circle

input:                   ;прерывание int0
	jb p3.2, $
	mov a, p3
	anl a, #0f0h
	mov varQ, a
	cpl f0
 	reti

formula:                 ;прерывание int1
	jb p3.3, $
	;умножение
	mov a, varQ
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
	;вывод
	mov a, zl
	call transform
	call output
	mov a, zh
	jz circle
	mov 05h, r0
	mov 04h, r1
	call transform
	mov 02h, r1
	mov 01h, r4
	mov 00h, r5
	call output
 	reti

wheel:
	jb f0, circle
	mov r3, a
	call transform
	call output
	jmp circle

output:
	;первый разряд
	mov a, r1
	movc a, @a+dptr
	mov p0, a
	;второй разряд
	mov a, r0
	movc a, @a+dptr
	mov p1, a
	;третий разряд
	mov a, r2
	movc a, @a+dptr
	mov p2, a
	ret

transform:
	mov b, #16
	div ab
	mov r1, b
	mov r0, a
	cjne r1, #16, d16
d16:    jnc transform
	ret


sjmp $
arr: db 3fh, 06h, 5bh, 4fh, 66h, 6dh, 7dh, 07h, 7fh, 6fh, 77h, 7ch, 39h, 5eh, 79h, 71h
;        0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F
end

