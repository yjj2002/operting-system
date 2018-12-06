;fat32结构定义如下
;typedef struct{//79字节
;	byte2	sectorSize;			//每扇区字节数
;	byte	clusterSectorNum;	//每簇扇区数
;	byte2	keepSectorNum;		//保留扇区数
;	byte	fatNum;				//fat数
;	byte2	a;//fat16 use
;	byte2	b;//fat16 use
;	byte	diskMedia;			//磁盘介质
;	byte2	c;//fat16 use
;	byte2	trackSectorNum;		//每个磁道扇区数
;	byte2	headerNum;			//磁头数
;	byte4	hiddenSectorNum;	//当前分区隐藏扇区数
;	byte4	diskSectorNum;		//磁盘扇区总数
;
;	byte4	fatSectorNum;		//每个fat表扇区数
;	byte2	flag;				//标记
;	byte2	version;			//版本
;	byte4	rootClusterNum;		//根目录入口簇号
;	byte2	fileSectorNum;		//文件系统扇区号
;	byte2	backupDBR;			//备份引导扇区位置
;	char	e[12];//fat16use
;	byte	biosDiskNum;		//BIOS驱动器号
;	byte	f;//fat16 use
;	byte	extendedBootFlag;	//扩展引导标志0x29
;	byte4	fatDiskSeriesNum;	//fat格式磁盘系列号
;	char	fatName[11];		//fat32卷标明
;	char	fatDiskSign[8];		//fat32磁盘格式标志
;}fat32BPB;
;
;typedef struct{
;	byte			jmpBin[3];				//跳转指令+空指令，jmp 0x5a / nop （机器码：0xeb 0x58 0x90）
;	char			manufacturersName[8];	//OEM代号,厂商名称
;	fat32BPB		bpb;					//BIOSParameter Block，BIOS参数块
;	char			bootcode[420];			//boot代码
;	byte2			flagNum;				//引导扇区标志0xaa55(由于是小端模式，实际的储存为0x55,0xaa)
;}fat32boot;

jmp start
nop
OEM		db	'LINDOR-X'	;厂商名字，8字节
sectorSize	dw	512		;每个扇区字节数，512字节
clusterSectorNum	db	8		;每簇扇区数，8
keepSectorNum	dw	31		;保留扇区，这里用来备份mbr
fatNum		db	2		;fat表数，一般为2个，第二个fat为第一个的备份
		dd	0		;这里fat32中没有用到
diskMedia	db	0xf8		;代表本地磁盘
		dw	0
trackSectorNum	dw	63		;每个磁道扇区数
headerNum	dw	2		;磁头数
hiddenSectorNum	dd	0		;当前分区隐藏扇区数
diskSectorNum	dd	204800		;磁盘总扇区数，100MB
fatSectorNum	dd	1560		;fat扇区数
flag		dw	0
version		dw	0
rootClusterNum	dd	394		;根目录入口簇号
fileSectorNum	dw	?		;文件系统扇区号
backupDBR	dw	1		;备份引导扇区位置
		dd	0,0,0
biosDiskNum	db	0x80		;BIOS驱动器号
		db	0
extendedBootFlag	db	0x29		;扩展引导标志0x29
fatDiskSeriesNum	dd	0x12345678	;fat格式磁盘系列号
fatName		db	'lindorx 0.1'	;fat32卷标明,11字节
fatDiskSign	db	'fat32   '		;fat32磁盘格式标志.8字节
;根目录位置=保留扇区数+fat占用扇区数*fat数+(起始簇号-2) x 每簇的扇区数

BOOTSEG EQU 07c0H
INITSEG	EQU 9000H
SYSMSEG EQU 1000H
_start:


times 510-($-$$) db 0
dw 0xaa55






