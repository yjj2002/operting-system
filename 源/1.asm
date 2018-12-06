program_length dd program_end
code_entry dw start
dd sectoin.code_1.start

section code_1 align=16 vstart=0
srart:
mov ax,cs
mov ds,ax
mov es,ax

mov cx,9
mov bx,0x0007
mov bp,msg
mov ax,0x1301
int 0x10

spin:
hlt
jmp spin

msg db "123456789"

program_end: