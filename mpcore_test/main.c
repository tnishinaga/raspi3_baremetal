#include "arm_pl011.h"

#define PERI_BASE_ADDR   (volatile uintptr_t)0x3F000000
#define PERI_UART0_ADDR  (PERI_BASE_ADDR + 0x00201000)

typedef struct {
    volatile uint64_t spin_cpu0;
    volatile uint64_t spin_cpu1;
    volatile uint64_t spin_cpu2;
    volatile uint64_t spin_cpu3;
} RPI_SPIN_TABLE;

extern void* _start;

int main(void)
{
    pl011_init(PERI_UART0_ADDR, 48000000, 115200);

    pl011_putc('0', PERI_UART0_ADDR);

    // wake-up second core!!
    volatile RPI_SPIN_TABLE *stbl = (RPI_SPIN_TABLE *)0xd8;

    stbl->spin_cpu1 = (uint64_t)&_start;
    stbl->spin_cpu2 = (uint64_t)&_start;
    stbl->spin_cpu3 = (uint64_t)&_start;
    __asm__("dsb sy");
    __asm__("sev");

    return 0;
}