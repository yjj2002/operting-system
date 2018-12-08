#include"./../macro/datatype.h"
inline void asm_cpu_hlt(void)
{
    __asm__ __volatile__ ("hlt");
}

inline void asm_cli(void)
{
    __asm__ __volatile__("cli");
}

inline void asm_sti(void)
{
    __asm__ __volatile__("sti");
}

inline void asm_lgdt(void)
{
    __asm__ __volatile__("lgdt");
}

inline void asm_inb(uint8* al,uint32 edx)
{
    __asm__ __volatile__("inb %%edx,%0":"=a"(al):"d"(edx));
}

inline uint16 asm_inw(uint32 edx)
{
    uint16 ax;
    __asm__ __volatile__("inw %%edx,%0":"=a"(ax):"d"(edx));
}

inline uint32 asm_ind(uint32 edx)
{
    uint32 eax;
    __asm__ __volatile__("inl %%edx,%0":"=a"(eax):"d"(edx));
}