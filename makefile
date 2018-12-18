img=lindorx.img

$(img):
	make -f /code/boot/makefile
	make -f /code/device/makefile
	dd if=/dev/zero of=$(img) count=256 bs=512
	dd if=/code/boot/bootloder.bin of=$(img) count=16 bs=512 conv=notcrun
	dd if=/code/boot/bootloder.bin of=$(img) count=16 seek=0 skip=16 conv=notcrun
	dd if=/code/device/device.bin of=$(img) count=2	seek=0 skip=32 conv=notcrun

bochs:$(img)
	bochs -f bochsrc.txt
dbg:$(img)
	bochsdbg -f bochsrc.txt

del_some:
	@del $(img).lock
cle:
	del $(img)

