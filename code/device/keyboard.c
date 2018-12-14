/*键盘控制函数，用来从键盘获取输入的字符并返回给调用的函数*/
#include"./../asm/base_asm.h"
#include"./../macro/datatype.h"
int sysmain()
{
    /*0x60为键盘控制器的数据端口，0x64为键盘控制器的命令端口*/
    /*读取i8042的状态寄存器*/
    //显示字符
    char* cbuf;
    cbuf=(char*)0xb8000;
    *cbuf='2';
    cbuf++;
    *cbuf='2';
    return 0;
}
