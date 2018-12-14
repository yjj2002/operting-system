	.file	"keyboard.c"
	.stabs	"keyboard.c",100,0,2,Ltext0
	.text
Ltext0:
	.stabs	"gcc2_compiled.",60,0,0,0
	.stabs	"int:t(0,1)=r(0,1);-2147483648;2147483647;",128,0,0,0
	.stabs	"char:t(0,2)=r(0,2);0;127;",128,0,0,0
	.stabs	"long int:t(0,3)=r(0,3);-2147483648;2147483647;",128,0,0,0
	.stabs	"unsigned int:t(0,4)=r(0,4);0;4294967295;",128,0,0,0
	.stabs	"long unsigned int:t(0,5)=r(0,5);0;4294967295;",128,0,0,0
	.stabs	"__int128:t(0,6)=r(0,6);0;-1;",128,0,0,0
	.stabs	"__int128 unsigned:t(0,7)=r(0,7);0;-1;",128,0,0,0
	.stabs	"long long int:t(0,8)=r(0,8);-0;4294967295;",128,0,0,0
	.stabs	"long long unsigned int:t(0,9)=r(0,9);0;-1;",128,0,0,0
	.stabs	"short int:t(0,10)=r(0,10);-32768;32767;",128,0,0,0
	.stabs	"short unsigned int:t(0,11)=r(0,11);0;65535;",128,0,0,0
	.stabs	"signed char:t(0,12)=r(0,12);-128;127;",128,0,0,0
	.stabs	"unsigned char:t(0,13)=r(0,13);0;255;",128,0,0,0
	.stabs	"float:t(0,14)=r(0,1);4;0;",128,0,0,0
	.stabs	"double:t(0,15)=r(0,1);8;0;",128,0,0,0
	.stabs	"long double:t(0,16)=r(0,1);12;0;",128,0,0,0
	.stabs	"_Decimal32:t(0,17)=r(0,1);4;0;",128,0,0,0
	.stabs	"_Decimal64:t(0,18)=r(0,1);8;0;",128,0,0,0
	.stabs	"_Decimal128:t(0,19)=r(0,1);16;0;",128,0,0,0
	.stabs	"void:t(0,20)=(0,20)",128,0,0,0
	.stabs	"./../asm/base_asm.h",130,0,0,0
	.stabs	"uint8:t(1,1)=(0,13)",128,0,0,0
	.stabs	"uint16:t(1,2)=(0,11)",128,0,0,0
	.stabs	"uint32:t(1,3)=(0,4)",128,0,0,0
	.stabs	"uint64:t(1,4)=(0,5)",128,0,0,0
	.stabs	"uint:t(1,5)=(1,3)",128,0,0,0
	.stabn	162,0,0,0
	.stabs	"./../macro/datatype.h",130,0,0,0
	.stabn	162,0,0,0
	.stabs	"asm_cpu_hlt:f(0,20)",36,0,0,_asm_cpu_hlt
	.def	_asm_cpu_hlt;	.scl	3;	.type	32;	.endef
_asm_cpu_hlt:
	.stabs	"./../asm/base_asm.h",132,0,0,Ltext1
Ltext1:
	.stabn	68,0,14,LM0-LFBB1
LM0:
LFBB1:
LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	.stabn	68,0,15,LM1-LFBB1
LM1:
/APP
 # 15 "./../asm/base_asm.h" 1
	hlt
 # 0 "" 2
	.stabn	68,0,16,LM2-LFBB1
LM2:
/NO_APP
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE0:
Lscope1:
	.stabs	"asm_inb:f(0,20)",36,0,0,_asm_inb
	.stabs	"al:p(0,21)=*(0,13)",160,0,0,8
	.stabs	"edx:p(0,4)",160,0,0,12
	.def	_asm_inb;	.scl	3;	.type	32;	.endef
_asm_inb:
	.stabn	68,0,29,LM3-LFBB2
LM3:
LFBB2:
LFB3:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	.stabn	68,0,30,LM4-LFBB2
LM4:
	movl	12(%ebp), %eax
	movl	%eax, %edx
/APP
 # 30 "./../asm/base_asm.h" 1
	in %dx,%eax
 # 0 "" 2
/NO_APP
	movl	%eax, 8(%ebp)
	.stabn	68,0,31,LM5-LFBB2
LM5:
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3:
Lscope2:
	.stabs	"sys_key_get:F(0,13)",36,0,0,_sys_key_get
	.globl	_sys_key_get
	.def	_sys_key_get;	.scl	2;	.type	32;	.endef
_sys_key_get:
	.stabs	"keyboard.c",132,0,0,Ltext2
Ltext2:
	.stabn	68,0,5,LM6-LFBB3
LM6:
LFBB3:
LFB8:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	.stabn	68,0,7,LM7-LFBB3
LM7:
	movb	$0, -5(%ebp)
	movb	$0, -1(%ebp)
	.stabn	68,0,8,LM8-LFBB3
LM8:
	movw	$100, -4(%ebp)
	.stabn	68,0,9,LM9-LFBB3
LM9:
	movzwl	-4(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-5(%ebp), %eax
	movl	%eax, (%esp)
	call	_asm_inb
	.stabn	68,0,10,LM10-LFBB3
LM10:
	movzbl	-5(%ebp), %eax
	movb	%al, -1(%ebp)
L4:
	.stabn	68,0,12,LM11-LFBB3
LM11:
	call	_asm_cpu_hlt
	jmp	L4
	.cfi_endproc
LFE8:
	.stabs	"al:(0,13)",128,0,0,-5
	.stabs	"ah:(0,13)",128,0,0,-1
	.stabs	"dx:(0,11)",128,0,0,-4
	.stabn	192,0,0,LFBB3-LFBB3
	.stabn	224,0,0,Lscope3-LFBB3
Lscope3:
	.stabs	"",100,0,0,Letext0
Letext0:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
