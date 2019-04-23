.align 4
.global _start
_start:
    // stop all interrupt
    // TODO: write
    // check current Exception Level
    // check cpu core id
    mrs x0, mpidr_el1
    // if core_id == 0 then goto primary_start
    cbz x0, primary_start
    // else goto secondary_start
    b secondary_start


primary_start:
    ldr x1, =0x1c000000
    mov sp, x1
    bl main
    b finish

secondary_start:
    // output core_id
    // TODO: write

    b finish

finish:
    wfe
    b finish