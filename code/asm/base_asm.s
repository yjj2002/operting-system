	.file	"base_asm.c"
	.text
	.globl	_asm_cpu_hlt
	.def	_asm_cpu_hlt;	.scl	2;	.type	32;	.endef
_asm_cpu_hlt:
LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
/APP
 # 11 "base_asm.c" 1
	hlt
 # 0 "" 2
/NO_APP
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE0:
	.globl	_asm_cli
	.def	_asm_cli;	.scl	2;	.type	32;	.endef
_asm_cli:
LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
/APP
 # 17 "base_asm.c" 1
	cli
 # 0 "" 2
/NO_APP
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE1:
	.globl	_asm_sti
	.def	_asm_sti;	.scl	2;	.type	32;	.endef
_asm_sti:
LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
/APP
 # 23 "base_asm.c" 1
	sti
 # 0 "" 2
/NO_APP
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2:
	.globl	_asm_lgdt
	.def	_asm_lgdt;	.scl	2;	.type	32;	.endef
_asm_lgdt:
LFB3:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
/APP
 # 29 "base_asm.c" 1
	lgdt
 # 0 "" 2
/NO_APP
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3:
	.globl	_asm_inb
	.def	_asm_inb;	.scl	2;	.type	32;	.endef
_asm_inb:
LFB4:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, %edx
/APP
 # 36 "base_asm.c" 1
	inb %edx,%al
 # 0 "" 2
/NO_APP
	movb	%al, -1(%ebp)
	movzbl	-1(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE4:
	.globl	_asm_inw
	.def	_asm_inw;	.scl	2;	.type	32;	.endef
_asm_inw:
LFB5:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, %edx
/APP
 # 43 "base_asm.c" 1
	inw %edx,%ax
 # 0 "" 2
/NO_APP
	movw	%ax, -2(%ebp)
	movzwl	-2(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE5:
	.globl	_asm_ind
	.def	_asm_ind;	.scl	2;	.type	32;	.endef
_asm_ind:
LFB6:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, %edx
/APP
 # 50 "base_asm.c" 1
	inl %edx,%eax
 # 0 "" 2
/NO_APP
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE6:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
