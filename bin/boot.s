.code16

GDT_ADDRESS = 0x1000		/*GDT表被加载的位置*/
HEAD_ADDRESS = 0x7E00		/*head文件被加载的位置*/

.text
.globl _start
_start:
	movw	$0x0003,%ax	/*设定显示模式，80*25，,16色文本*/
	int	$0x10

	xor	%ax,%ax
	movw	%ax,%es
	movw	%ax,%ds
	/*将磁盘服务加载到实模式下的中断区域，中断号0*/
	movw	$read_disk,%ax
	movw	%ax,%es:0
	movw	%ax,%es:2
	/*打印函数中断号为0*/
	movw	$print,%ax
	movw	%ax,%es:4
	movw	%ax,%es:6
	/*提示加载信息*/
	push	message
	push 	21
	push	0x0200
	int	$1
	/*加载head.bin*/
	movb	$15,%cl
	movw	$1,%bx
	movw	$HEAD_ADDRESS,%di
	xor	%ax,%ax
	movw	%ax,%es
	int	$0
	/*加载GDT表，用于保护模式初始化*/
	movb	$2,%cl
	movw	$32,%bx
	movw	$GDT_ADDRESS,%di
	xor	%ax,%ax
	movw	%ax,%es
	int	$0
	jmp	$0x7e00,$0

read_disk:
	pusha
	movb	%cl,%al
	movw	$0x1f2,%dx
	out	%al,%dx

	mov 	%bl,%al
	inc	%dx
print: