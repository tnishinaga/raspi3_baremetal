#include "arm_pl011.h"

#define PERI_BASE_ADDR   (volatile uintptr_t)0x3F000000
#define PERI_UART0_ADDR  (PERI_BASE_ADDR + 0x00201000)

extern void* _start;

int my_putc(int c)
{
    return pl011_putc(c, PERI_UART0_ADDR);
}

int my_puts(const char *s)
{
    while(*s != '\0') {
        my_putc(*s);
        s++;
    }
    my_putc('\n');
    return 0;
}

int main(void)
{
    pl011_init(PERI_UART0_ADDR, 48000000, 115200);

    my_puts("Hello!");
    
    return 0;
}