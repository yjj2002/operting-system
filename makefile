boot=code\boot
bin=bin
#源文件路径
bootasm=$(boot)\boot.asm
headasm=$(boot)\head.asm
GDTlist=$(boot)\GDTlist.asm
#二进制文件路径
bootbin=$(bin)\boot.bin
headbin=$(bin)\head.bin
bootloder=$(bin)\bootloder.bin
GDT_list_init=$(boot)\GDTlist.bin
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

$(bootbin):$(bootasm)
	fasm $(bootasm) $(bootbin)
$(headbin):$(headasm)
	fasm $(headasm) $(headbin)
$(GDT_list_init):$(GDTlist)
	fasm $(GDTlist) $(GDT_list_init)

bochs:$(img)
	bochs -f bochsrc.txt
dbg:$(img)
	bochsdbg -f bochsrc.txt

del_some:
	@del $(img).lock
cle:
	del $(bootbin) $(headbin) $(img) $(bootloder)