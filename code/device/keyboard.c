#include"./../asm/base_asm.h"
#include"DC.h"

/*磁盘读取函数
*sector:起始扇区；
*size：读取扇区数
*mem：待写入内存区域（处于平坦模型下时）
*/
#define DISK_PORT0  0x1f0
#define DISK_PORT1  0x1f1
#define DISK_PORT2  0x1f2
#define DISK_PORT3  0x1f3
#define DISK_PORT4  0x1f4
#define DISK_PORT5  0x1f5
#define DISK_PORT6  0x1f6
#define DISK_PORT7  0x1f7
int sys()
{
        sysDiskRead(0,2,0xb8000);
        while(1){
                asm_cpu_hlt();
        }
        return 0;
}