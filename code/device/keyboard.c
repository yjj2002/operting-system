/*键盘控制函数，用来从键盘获取输入的字符并返回给调用的函数*/
#include"./../asm/base_asm.h"
#include"./../macro/datatype.h"
uint8 sys_key_get()
{
    /*0x60为键盘控制器的数据端口，0x64为键盘控制器的命令端口*/
    uint8 al=0;
    uint32 edx=0x60;
    asm_inb(&al,edx);

    return al;
}