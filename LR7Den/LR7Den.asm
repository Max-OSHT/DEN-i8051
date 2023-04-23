xl equ 30h
N equ 31h

org 00h
jmp main

org 0bh
jmp timer

org 30h
main:
	mov sp, #100
	mov dptr, #arr
	;first value
	mov xl, #3
	;activation ports
	mov p0, #0
	mov p1, #0
	mov p2, #0
	mov p3, #0ffh
	mov p0, xl
	;timer activatin
	mov tl0, #low(7628h)
	mov th0, #high(7628h)
	mov tmod, #01h
	mov ie, #82

;=================================
loop:
	jnb tr0, check
	jnb tf0, $
	clr tf0
	djnz r0, check
	mov r0, N
	call timer
	jmp loop
;=================================
;проверка периферии
check:
	mov 24h, tcon
	jb p3.4, pusk      ;кнопка Пуск/Стоп
	jb p3.5, input     ;кнопка Ввод периода
	jmp wheel
	jmp loop
	
;обработчик прерывания от таймера
timer:
        mov tl0, #low(7628h)
	mov th0, #high(7628h)
	mov a, xl
	rl a
	mov xl, a
	mov p0, xl
	reti
	
;кнопка пуск/стоп
pusk:
	jb p3.4, $
	cpl tr0
	jmp loop

;кнопка ввода периода
input:
	jb p3.5, $
	mov a, p3
	anl a, #15
	mov b, #5
	mul ab
	mov N, a
	jmp loop

;получение значений с АЦП
wheel:
	mov a, p3
	anl a, #15
	call transform
	call output
	jmp loop

output:
	;первый разряд
	mov a, r2
	movc a, @a+dptr
	mov p1, a
	;второй разряд
	mov a, r1
	movc a, @a+dptr
	add a, #80h
	mov p2, a
	ret

transform:
	mov b, #0ah
	div ab
	mov r2, b
	mov r1, a
	cjne r2, #0ah, d16
d16:    jnc transform
	ret

sjmp $
arr: db 3fh, 06h, 5bh, 4fh, 66h, 6dh, 7dh, 07h, 7fh, 6fh, 80h
;        0    1    2    3    4    5    6    7    8    9    d
end
