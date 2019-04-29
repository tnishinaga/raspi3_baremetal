#define UART0_DR_ADDR (0x3F000000 + 0x00201000)

.section ".text.start"
.align 4
.global _start
_start:
    // in EL2
    // disable all interrupt(daif at bits 9..6)
    msr DAIFSet, #0x0f
    // check cpu core id(less than 4 core)
    mrs x0, mpidr_el1
    and x0, x0, #0x03
    // if core_id == 0 then goto primary_start
    cbz x0, primary_start
    // else spin
    b finish

primary_start:
    // TODO: enter_el1
    ldr x1, =__stack_end
    mov sp, x1
    bl bss_clear
    bl main
    b finish

bss_clear:
    mov x0, #0
    ldr x1, __bss_start
    ldr x2, __bss_end
1:
    cmp x1, x2
    beq 2f
    str w0, [x1]
    add x1, x1, #4
    b 1b
2:
    ret

finish:
    wfe
    b finish