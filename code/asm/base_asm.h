/*一些C语言中无法实现的汇编指令*/
/*汇编指令实现*/
#define __asm__ asm
#define __volatile__ volatile
typedef unsigned char uint8;    //8位无符号整数
typedef unsigned short uint16;   //16位无符号整数
typedef unsigned int uint32;     //32位无符号整数
typedef unsigned long uint64;    //64位无符号整数

typedef uint32 uint;
typedef uint8 byte;

/*hlt指令*/
static inline void asm_cpu_hlt(void)
{
    __asm__ __volatile__("hlt");
}
/*清中断指令*/
static inline void asm_cli(void)
{
    __asm__ __volatile__("cli");
}
/*开中断*/
static inline void asm_sti(void)
{
    __asm__ __volatile__("sti");
}
/*8位读端口指令*/
static inline void asm_inb(uint8 *al,uint32 edx)
{
    __asm__ __volatile__("in %%dx,%0":"=a"(al):"d"(edx));
}
/*16位读端口指令*/
static inline void asm_inw(uint16 *ax,uint16 edx)
{
    __asm__ __volatile__("in %%dx,%0":"=a"(ax):"d"(edx));
}
/*8位写端口指令*/
static inline void asm_outb(uint8 *al,uint32 edx)
{
    __asm__ __volatile__("out %0,%%dx":"=a"(al):"d"(edx));
}
/*16位写端口指令*/
static inline void asm_outw(uint16 *ax,uint32 edx)
{
    __asm__ __volatile__("out %0,%%dx":"=a"(ax):"d"(edx));
}

static inline void asm_int(const uint var)
{
    __asm__ __volatile__("int %0"::"N"(var));
}
