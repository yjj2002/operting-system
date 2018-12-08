boot=code\boot
dev=device
bin=bin


#编译选项
GCC_option=-nostdinc -fno-stack-protector -fno-tree-ch -Wall -Wno-format -Wno-unused -Werror -gstabs -m32 -fno-omit-frame-pointer -DJOS_KERNEL -gstabs -c -o
LD_option=-m elf_i386 -N -e entry -Ttext 0 -o
OBJ_option=-S -O binary -j .text -j .data
#源文件路径
bootasm=$(boot)\boot.asm
headasm=$(boot)\head.asm
GDTlist=$(boot)\GDTlist.asm

key=$(dev)\keyboard.c
#二进制文件路径
bootbin=$(bin)\boot.bin
headbin=$(bin)\head.bin
bootloder=$(bin)\bootloder.bin
GDT_list_init=$(bin)\GDTlist.bin

keybin=$(bin)\keyboard.bin
#镜像文件
img=lindorx.img

$(img):$(bootbin) $(headbin) $(GDT_list_init)
	dd if=/dev/zero of=$(img) bs=512 count=50
#合并boot.bin和head.bin
	copy $(bootbin)/b+$(headbin)/b $(bootloder)
#将bootloder写入镜像文件的前32扇区，写两遍，0~15为可执行的部分，16~31为备份
	dd if=$(bootloder) of=$(img) conv=notrunc skip=0 seek=0 bs=512 count=16
	dd if=$(bootloder) of=$(img) conv=notrunc skip=0 seek=16 bs=512 count=16
#将初始化时的GDT表写入32~33扇区
	dd if=$(GDT_list_init) of=$(img) conv=notrunc skip=0 seek=32 bs=512 count=2
	

#*******************bootloder*************************************
$(bootbin):$(bootasm)
	fasm $(bootasm) $(bootbin)
$(headbin):$(headasm)
	fasm $(headasm) $(headbin)
$(GDT_list_init):$(GDTlist)
	fasm $(GDTlist) $(GDT_list_init)

#******************kernel******************************************
$(keybin):$(key)
	gcc $(GCC_option) keyboard.o $(key)
	ld $(LD_option) keyboard.out keyboard.o
	objcopy $(OBJ_option) keyboard.out keybin

bochs:$(img)
	bochs -f bochsrc.txt
dbg:$(img)
	bochsdbg -f bochsrc.txt

del_some:
	@del $(img).lock
cle:
	del $(bootbin) $(headbin) $(img) $(bootloder)