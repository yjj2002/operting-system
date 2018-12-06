;name:boot.asm
;coding:UTF-8
include 'macro-con.inc'
use16
org 0x7c00
_start:
;当计算机初始化之后，首先进入80*25的字符模式,现在重新设定格式以缓冲区
mov ah,0
mov al,0x03
int 0x10

xor ax,ax
mov es,ax
mov ds,ax
;将磁盘服务设定到实模式下的中断区域，中断号为0
mov ax,read_disk
mov [es:0x00],ax
mov [es:0x02],bx
;显示中断号为1
mov ax,print
mov [es:0x04],word ax
mov [es:0x06],word bx
;显示正在加载中
push message
push 21
push 0x0200
int 1
;加载head.bin。这个文件用于进入32位并完成一些初始化设定。跟在mbr后面，即从扇区1开始
mov cl,15
mov bx,1
mov di,HEAD_ADDRESS
xor ax,ax
mov es,ax
int 0
;读取GDT表，共2个扇区，位置在磁盘的32~33,存入0x1000处，避开实模式下的中断向量表
mov cl,2
mov bx,32
mov di,GDT_ADDRESS
xor ax,ax
mov es,ax
int 0
;跳转到0x7e00，将控制权交给head
jmp 0:0x7e00

message db "loading head.bin...",0x0d,0x0a

;*****************************************************
;读取磁盘，读取的扇区数存入cl,读取扇区号存入bx，被写入的地址存入di,段地址存es
read_disk:
pusha
mov al,cl
mov dx,0x1f2
out dx,al

mov al,bl
inc dx
out dx,al

mov al,bh
inc dx
out dx,al

mov al,0
inc dx
out dx,al

mov al,11100000b
inc dx
out dx,al

mov al,0x20
inc dx
out dx,al

.waits:

in al,dx
and al,0x88
cmp al,0x08

jnz .waits

mov dx,0x1f0
imul cx,cx,256
loop2:
in ax,dx
mov word [es:di],ax
add di,2
loop loop2
popa
ret

;*****************************************************
;获取光标位置,x存ah，y存al
get_pos:
push dx
push bx

mov al,0x0e
mov dx,0x03d4
out dx,al
mov dx,0x03d5
in al,dx
mov bl,al

mov al,0x0f
mov dx,0x3d4
out dx,al
mov dx,0x03d5
in al,dx
mov ah,bl
pop bx
pop dx
ret
;*****************************************************
;修改光标位置,ah=x,al=y
put_pos:
push dx
push bx

mov bx,ax

mov dx,0x03d4
mov al,0xe
out dx,al

mov dx,0x03d5
mov al,bh
out dx,al

mov dx,0x03d4
mov al,0x0f
out dx,al

mov dx,0x03d5
mov al,bl
out dx,al

mov ax,bx
pop bx
pop dx
ret
;*****************************************************
;push 进字符串地址，push进字符数，push进背景色
STRING equ 0x1c ;字符串地址
SIZE equ 0x1a;字符数量
COLOR equ 0x18;背景色前景色
print:
	pusha
	push bp
	mov bp,sp
	mov ax,0xb800
	mov es,ax

	mov di,word [bp+STRING]	;di字符串地址
	mov cx,word [bp+SIZE]	;cx字符数
	mov dx,word [bp+COLOR]	;颜色
	call get_pos
outstr:
	mov dl,[di]
	call judeg
	inc di
	loop outstr
end_print:
	pop bp
	popa
	iret
;-------------------------------------------------------
judeg:
judge_back:	;判断退格
	cmp dl,0x08
	jz ch_back
	jmp judge_tab
ch_back:
	cmp ax,0
	jle next
	dec ax
	call put_pos
	imul bx,ax,2
	mov word [es:bx],0
	jmp next
;-------------------------------------------------------
judge_tab:	;判断制表符
	cmp dl,0x09
	jz ch_tab
	jmp judge_enter
ch_tab:
	mov dl,8
	mov bx,ax
	div dl
	mov al,8
	sub al,ah
	xor ah,ah
	add bx,ax
	mov ax,bx
	call put_pos
	jmp next
;-------------------------------------------------------
judge_enter:	;判断回车
	cmp dl,0x0d
	jz ch_enter
	jmp judge_newline
ch_enter:
	push dx
	mov bx,ax
	mov dl,80
	div dl	;al储存商，ah储存余数
	pop dx
	shr ax,8
	sub bx,ax
	mov ax,bx
	call put_pos
	jmp next
;--------------------------------------------------------
judge_newline:	;判断换行
	cmp dl,0x0a
	jz ch_newline
	jmp judge_ch
ch_newline:
	cmp ax,1840
	jae calup
	jmp n1
calup:
	call roll_up
	jmp next
n1:
	add ax,80
	call put_pos
	jmp next
;---------------------------------------------------------
judge_ch:		;判断是否为可输出字符，小于0x20，大于0x7e不可输出
	cmp dl,0x20
	jl next
	cmp dl,0x7e
	ja next
mov_cursor:
	inc ax
	call put_pos
outch:
	mov bx,ax
	dec bx
	imul bx,2
	mov word [es:bx],dx
next:
	ret
;-----------------------------------------------------------
;向上滚动一行
roll_up: 
	push ds
	push es
	push cx
	push di
	mov bx,0xb800
	mov ds,bx
	mov bx,0xb7f6
	mov es,bx
	xor di,di
	xor si,si
	mov cx,2000  ;共传送80*25字
	rep movsw
	pop di
	pop cx
	pop es
	pop ds
	ret

;*****************************************************


times 510-($-$$) db 0
dw 0xaa55
