#这个makefile负责编译当前目录下的文件，生成bin文件
o1=keyboard.o DC.o diskCtrl.o 

GCC_LIST=-nostdinc -fno-stack-protector -fno-tree-ch -Wall -Wno-format -Wno-unused -Werror -gstabs -m32 -fno-omit-frame-pointer -DJOS_KERNEL -gstabs -c -o 
LD_LIST=-m i386pe -N -e _sys -Ttext 0 -o

device.bin:dev.out
	objcopy -S -O binary -j .text -j .data dev.out device.bin

dev.out:$(o1)
	ld $(LD_LIST) dev.out $(o1)

keyboard.o:keyboard.c
	gcc $(GCC_LIST) $@ $<

DC.o:DC.c
	gcc $(GCC_LIST) $@ $<

diskCtrl.o:diskCtrl.s
	gcc $(GCC_LIST) $@ $<

cle:
	del dev.out keyboard.o DC.o diskCtrl.o