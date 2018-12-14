	.file	"keyboard.c"
	.text
	.globl	_sys_key_get
	.def	_sys_key_get;	.scl	2;	.type	32;	.endef
_sys_key_get:
LFB8:
	.cfi_startproc
/APP
 # 15 "./../asm/base_asm.h" 1
	hlt
 # 0 "" 2
/NO_APP
	movl	$0, %eax
	ret
	.cfi_endproc
LFE8:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
