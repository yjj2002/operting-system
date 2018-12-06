;fat32�ṹ��������
;typedef struct{//79�ֽ�
;	byte2	sectorSize;			//ÿ�����ֽ���
;	byte	clusterSectorNum;	//ÿ��������
;	byte2	keepSectorNum;		//����������
;	byte	fatNum;				//fat��
;	byte2	a;//fat16 use
;	byte2	b;//fat16 use
;	byte	diskMedia;			//���̽���
;	byte2	c;//fat16 use
;	byte2	trackSectorNum;		//ÿ���ŵ�������
;	byte2	headerNum;			//��ͷ��
;	byte4	hiddenSectorNum;	//��ǰ��������������
;	byte4	diskSectorNum;		//������������
;
;	byte4	fatSectorNum;		//ÿ��fat��������
;	byte2	flag;				//���
;	byte2	version;			//�汾
;	byte4	rootClusterNum;		//��Ŀ¼��ڴغ�
;	byte2	fileSectorNum;		//�ļ�ϵͳ������
;	byte2	backupDBR;			//������������λ��
;	char	e[12];//fat16use
;	byte	biosDiskNum;		//BIOS��������
;	byte	f;//fat16 use
;	byte	extendedBootFlag;	//��չ������־0x29
;	byte4	fatDiskSeriesNum;	//fat��ʽ����ϵ�к�
;	char	fatName[11];		//fat32�����
;	char	fatDiskSign[8];		//fat32���̸�ʽ��־
;}fat32BPB;
;
;typedef struct{
;	byte			jmpBin[3];				//��תָ��+��ָ�jmp 0x5a / nop �������룺0xeb 0x58 0x90��
;	char			manufacturersName[8];	//OEM����,��������
;	fat32BPB		bpb;					//BIOSParameter Block��BIOS������
;	char			bootcode[420];			//boot����
;	byte2			flagNum;				//����������־0xaa55(������С��ģʽ��ʵ�ʵĴ���Ϊ0x55,0xaa)
;}fat32boot;

jmp start
nop
OEM		db	'LINDOR-X'	;�������֣�8�ֽ�
sectorSize	dw	512		;ÿ�������ֽ�����512�ֽ�
clusterSectorNum	db	8		;ÿ����������8
keepSectorNum	dw	31		;����������������������mbr
fatNum		db	2		;fat������һ��Ϊ2�����ڶ���fatΪ��һ���ı���
		dd	0		;����fat32��û���õ�
diskMedia	db	0xf8		;�����ش���
		dw	0
trackSectorNum	dw	63		;ÿ���ŵ�������
headerNum	dw	2		;��ͷ��
hiddenSectorNum	dd	0		;��ǰ��������������
diskSectorNum	dd	204800		;��������������100MB
fatSectorNum	dd	1560		;fat������
flag		dw	0
version		dw	0
rootClusterNum	dd	394		;��Ŀ¼��ڴغ�
fileSectorNum	dw	?		;�ļ�ϵͳ������
backupDBR	dw	1		;������������λ��
		dd	0,0,0
biosDiskNum	db	0x80		;BIOS��������
		db	0
extendedBootFlag	db	0x29		;��չ������־0x29
fatDiskSeriesNum	dd	0x12345678	;fat��ʽ����ϵ�к�
fatName		db	'lindorx 0.1'	;fat32�����,11�ֽ�
fatDiskSign	db	'fat32   '		;fat32���̸�ʽ��־.8�ֽ�
;��Ŀ¼λ��=����������+fatռ��������*fat��+(��ʼ�غ�-2) x ÿ�ص�������

BOOTSEG EQU 07c0H
INITSEG	EQU 9000H
SYSMSEG EQU 1000H
_start:


times 510-($-$$) db 0
dw 0xaa55






