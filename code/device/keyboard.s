	.file	"keyboard.c"
	.text
	.globl	_sys_key_get
	.def	_sys_key_get;	.scl	2;	.type	32;	.endef
_sys_key_get:
LFB7:
	.cfi_startproc
	movl	$96, %edx
/APP
 # 24 "./../asm/base_asm.h" 1
	inb %edx,%eax
 # 0 "" 2
/NO_APP
	movl	$0, %eax
	ret
	.cfi_endproc
LFE7:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
