xl equ 30h
xh equ 31h
yl equ 32h
yh equ 33h
rezlS equ 20h
rezhS equ 21h
rezhD equ 22h
rezlD equ 23h
rezl equ 24h
rezh equ 25h

org 00h
jmp main

org 30h
main:
        mov xl, #low(2059)  ;0B
        mov xh, #high(2059) ;08
	mov yl, #low(5555)  ;B3
	mov yh, #high(5555) ;15
	;вычитание
	clr c
	mov a, xl
	subb a, yl
	mov rezlS, a
	mov a, xh
	subb a, yh
	mov rezhS, a

	;деление
	mov a, xh
	mov b, yh
	div ab
	mov rezhD, a
	mov rezlD, b
	
	;вычитание двух слагаемых
	clr c
	mov a, rezhS
	subb a, rezhD
	mov rezl, a
	clr c
	mov a, rezlS
	subb a, rezlD
	mov rezh, a
sjmp $
end
