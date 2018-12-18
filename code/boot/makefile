#负责处理bootloder
bootloder.bin:boot.bin head.bin
	copy boot.bin/b+head.bin/b bootloder.bin

boot.bin:boot.asm
	fasm boot.asm boot.bin

head.bin:head.asm
	fasm head.asm head.bin