varl equ 30h
varh equ 31h

org 00h
jmp main

org 03h
jmp impulse

org 30h
main:
	mov sp, #100
	mov dptr, #arr
	;activation
	mov p0, #0
	mov p1, #0
	mov p2, #0
	mov p3, #4
	;first value
	mov tl0, #0
	mov th0, #0
	;activation int0
	mov tmod, #9
	mov tcon, #17
	mov ie, #81h

;=================================
loop:
	jnb ie0, $
	clr ie0
        setb tr0
	jnb ie0, $
	clr tr0
	call impulse
	jmp loop
;=================================

impulse:
	mov varl, tl0
	mov varh, th0
	mov tl0, #0
	mov th0, #0
	clr ie0
	call output
	reti
	
output:
	;младший байт
	mov a, varl
	anl a, #0fh
	mov r3, a
	mov a, varl
	anl a, #0f0h
	swap a
	mov r2, a
	;старщий байт
	mov a, varh
	anl a, #0fh
	mov r1, a
	mov a, varh
	anl a, #0f0h
	swap a
	mov r0, a
	
	;первый разряд
	mov a, r2
	movc a, @a+dptr
	mov p0, a
	;второй разряд
	mov a, r1
	movc a, @a+dptr
	add a, #80h
	mov p1, a
	;третий разряд
	mov a, r0
	movc a, @a+dptr
	mov p2, a
	ret
	
sjmp $
arr: db 3fh, 06h, 5bh, 4fh, 66h, 6dh, 7dh, 07h, 7fh, 6fh, 77h, 7ch, 39h, 5eh, 79h, 71h, 80h
;        0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F    d
end
