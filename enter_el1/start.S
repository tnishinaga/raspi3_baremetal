#define UART0_DR_ADDR (0x3F000000 + 0x00201000)

.section ".text.start"
.align 4
.global _start
_start:
    // in EL2
    // disable all interrupt(daif at bits 9..6)
    msr DAIFSet, #0x0f
    bl debug_spin
    // check cpu core id(less than 4 core)
    mrs x0, mpidr_el1
    and x0, x0, #0x03
    // if core_id == 0 then goto primary_start
    cbz x0, primary_el2
    // else spin
    b finish

primary_el2:
    msr sctlr_el1, xzr
    // HCR: Hypervisor Configuration Register
    // Ref: ARM DDI0487D.a D12.2.2.44
    mrs x0, hcr_el2
    orr x0, x0, #(1<<31) // HCR_EL2.RW = AArch64 mode
    msr hcr_el2, x0

    // setup SPSR_EL2(to set CPSR_EL1)
    // Ref: ARM DDI0487D.a C5.2.17
    mov x0, #0b00101 // DAIF = 0, M[4:0] = El1h
    msr spsr_el2, x0

    // set el1 entry point
    adr x0, primary_el1
    // set return address to elr_el2
    msr elr_el2, x0
    // return to el1(pc <- elr_el2)
    eret

primary_el1:
    // disable all interrupt
    // TODO: is it unnecessary instruction?
    msr DAIFSet, #0x0f
    // set stack pointer
    ldr x0, =__stack_start
    mov sp, x0
    bl bss_clear
    b _start_main

_start_main:
    bl main
    b finish

bss_clear:
    ldr x1, __bss_start
    ldr x2, __bss_end
1:
    cmp x1, x2
    beq 2f
    str wzr, [x1]
    add x1, x1, #4
    b 1b
2:
    ret

finish:
    wfe
    b finish

debug_spin:
    mov x0, xzr
1:
    cbz x0, 1b
    ret
