/*汇编指令实现*/
#define __asm__ asm
#define __volatile__ volatile
typedef unsigned char uint8;    //8位无符号整数
typedef unsigned short uint16;   //16位无符号整数
typedef unsigned int uint32;     //32位无符号整数
typedef unsigned long uint64;    //64位无符号整数

typedef uint32 uint;

inline void asm_cpu_hlt(void)
{
    __asm__ __volatile__ ("hlt");
    return;
}

inline void asm_cli(void)
{
    __asm__ __volatile__("cli");
    return;
}

inline void asm_sti(void)
{
    __asm__ __volatile__("sti");
    return;
}

inline void asm_lgdt(void)
{
    __asm__ __volatile__("lgdt");
    return;
}

inline uint8 asm_inb(uint32 edx)
{
    uint8 al;
    __asm__ __volatile__("inb %%edx,%0":"=a"(al):"d"(edx));
    return al;
}

inline uint16 asm_inw(uint32 edx)
{
    uint16 ax;
    __asm__ __volatile__("inw %%edx,%0":"=a"(ax):"d"(edx));
    return ax;
}

inline uint32 asm_ind(uint32 edx)
{
    uint32 eax;
    __asm__ __volatile__("inl %%edx,%0":"=a"(eax):"d"(edx));
    return eax;
}
