use32
;向屏幕打印一个字符32位*******************************************************
;要显示的字符存入al，前背景色存入ah
print_char:
	pushad
	push ds
	mov cx,0x10		;设定段选择子，选择是gdt的#2表项定义的数据段,这里指向画面缓冲区
	mov es,cx
	mov ds,cx
	call get_pos		;获得光标的位置,存在ecx中
	imul ebx,ecx,2		;ebx为当前字符区偏移量
judge:		;判断字符类型
judge_back:	;退格
	cmp al,0x08
	jz ch_back
	jmp judge_tab
ch_back:
	cmp ecx,0
	jz end_char
	dec ecx				;令光标后退一格
	call put_pos
	mov word [es:ebx],0x7000	;清除字符
	jmp end_char
judge_tab:
	cmp al,0x09
	jz ch_tab
	jmp judge_enter
ch_tab:
	mov esi,2000
	mov eax,ecx
	and eax,111b
	cmp eax,0
	jz a1
	jmp a2
a1:
	add eax,8
a2:
	mov edi,2000
	add edi,eax
	imul edi,2
	imul esi,2
	;设置转移次数
	mov eax,2000
	sub eax,ecx
	shr eax,1
	mov ecx,eax
	inc ecx
	std
	rep movsd
	cld
	mov ecx,4
	mov ebx,0
loop1:
	mov dword [es:ebx],0x07200720
	add ebx,4
	loop loop1
	jmp end_char

judge_enter:
	cmp al,0x0d
	jz ch_enter
	jmp judge_newline
ch_enter:
	mov ax,cx
	mov bl,80
	div bl		;商在al，余数在ah
	movzx eax,ah
	sub cx,ax
	call put_pos
	jmp end_char

judge_newline:		;将光标平移到下一行
	cmp al,0x0a
	jz ch_newline
	jmp judeg_ch
ch_newline:
	cmp ecx,1840
	jae b1		;如果光标的位置大于等于1840，就将整体内容向前平移160字节
	jmp b2
b1:
	mov esi,160
	mov edi,0
	mov ecx,960
	rep movsd
	jmp end_char
b2:
	add ecx,80
	call put_pos
	jmp end_char
judeg_ch:	;判断字符是否可输出
	cmp al,0x20
	jl end_char
	cmp al,0x7e
	ja end_char
char:	;字符输出
	inc ecx
	call put_pos
	mov word [es:ebx],ax
end_char:
	pop ds
	popad
	ret
;--------------------------------------------------------------------------
;向屏幕打印一个字符串********************************************************
;使用前要先制定一个段选择子,指向要读取的数据段，存入ax。偏移量存入ebx,字符数存入ecx，前背景色存入dl
print_string:
pushad
push ds
mov ds,ax
mov ah,dl
loop_ch:
mov al,byte [ds:ebx]
call print_char
inc ebx
loop loop_ch
pop ds
popad
ret
;*************************************************************************

;字符显示程序32位下的*********************************************
;读取光标位置，返回到ecx中
get_pos:
push eax
push edx
xor ecx,ecx
mov ax,0x0f0e
mov dx,0x03d4
out dx,al
mov dx,0x03d5
in al,dx
mov ch,al

mov al,ah
mov dx,0x03d4
out dx,al
mov dx,0x03d5
in al,dx
mov cl,al
pop edx
pop eax
ret
;*******************************************************
;修改光标的位置，值存入cx
put_pos:
push eax
push edx
mov ax,0x0f0e
mov dx,0x03d4
out dx,al
mov dx,0x03d5
mov al,ch
out dx,al

mov al,ah
mov dx,0x03d4
out dx,al
mov dx,0x03d5
mov al,cl
out dx,al
pop edx
pop eax
ret
;*******************************************************
;字符串转换例程


;*******************************************************