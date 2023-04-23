varQ equ 30h

org 00h
jmp main

org 30h
main:
	;активация кнопок
	mov p1, #0
	mov p2, #0ffh
	mov p3, #0feh

circle:
	jb p3.1, input
	jb p3.2, Sleft
	jb p3.3, Sright
	jb p3.4, Default
	jb psw.6, light
	jmp circle

input:
	jb p3.1, $
	mov a, p2
	mov varQ, a
	mov p1, a
	jmp circle
	
Sleft:
       jb p3.2, $
       mov a, varQ
       rl a
       mov p1, a
       mov varQ, a
       jmp circle
       
Sright:
	jb p3.3, $
	mov a, varQ
        rr a
        mov p1, a
        mov varQ, a
        jmp circle
        
Default:
	jb p3.4, $
	mov p1, #0
	mov varQ, #0
	jmp circle

light:
	setb p3.0
	jmp circle
	
sjmp $
end
