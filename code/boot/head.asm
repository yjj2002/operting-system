;name:head.asm
;text:UTF-8
;head跟在boot文件的后面，处于1~15扇区
include 'macro-con.inc'
use16
;提示head已经加载完成
push msg+0x7e00
push 39
push 0x0200
int 1

;准备进入32位
 ;设置堆栈段和栈指针 ，设定0x7c00之前的内存空间为栈。
 mov ax,cs 
 mov ss,ax 
 mov sp,0x7c00
;加载gdt表
 lgdt ptr gdt_size+0x7e00
 ;打开A20地址线
 in al,0x92 ;南桥芯片内的端口 
 or al,0000_0010B 
 out 0x92,al ;打开A20 
 cli 
 ;保护模式下中断机制尚未建立，应 
 ;禁止中断

 mov eax,cr0
 or eax,1
 mov cr0,eax ;设置PE位 
;以下进入保护模式... ... 
;16位的描述符选择子：32位偏移
;jmp,清流水线并串行化处理器
jmp dword 0x8:flush

;进入保护模式
use32
flush:
;输出提示字符
mov ax,8
mov ecx,18
mov ebx,OK32
mov dl,0x02
call print_string

;检测是否支持cpuid指令
pushfd
mov eax,dword [esp]
xor dword [esp],0x200000
popfd
pushfd
pop ebx
cmp eax,ebx
jne support
jmp spin
support:
	mov ax,0x20
	mov es,ax
	mov eax,0
	cpuid	;执行cpuid指令后，返回信息以字符串形式储存在edx，ebx，ecx
	mov eax,'CPU:'
	mov dword [es:0],eax
	mov dword [es:4],ebx
	mov dword [es:8],edx
	mov dword [es:12],ecx
	mov ax,0x0a0d
	mov word [es:16],ax
	mov ax,0x20
	mov ecx,18
	mov ebx,0
	mov dl,0x02
	call print_string

;这一段留给加载内核的程序
mov ebx,34
mov ecx,2
mov ax,100000b
mov es,ax
mov edi,0
call read_disk

spin:
hlt
jmp spin

msg db "head is OK!",0x0d,0x0a,"system initialization...",0x0d,0x0a
OK32 db 0x0d,0x0a,"protected mode",0x0d,0x0a

;包含在保护模式下的字符输出函数
include 'fun32.inc'

align 16
;GDT表将被加载到0x1000扇区
gdt_size:
dw 55
dd GDT_ADDRESS

