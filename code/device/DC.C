#include"diskCtrl.h"
typedef unsigned char uint8;
typedef unsigned int uint;

int sysDiskRead(int sector,uint8 size,uint mem)
{
        __asm__ __volatile__("mov %0,%%ebx"::"g"(sector));
        __asm__ __volatile__("mov %0,%%cl"::"g"(size));
        __asm__ __volatile__("mov %0,%%edi"::"g"(mem));
        diskRead();
        return 0;
}