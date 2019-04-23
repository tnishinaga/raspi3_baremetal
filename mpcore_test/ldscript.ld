OUTPUT_ARCH(arm64)

ENTRY(_start)

SECTIONS
{
	. = 0x80000;

	.text : { *(.text*) }
	. = ALIGN(4);

	__rodata_start = .;
	.rodata : { *(.rodata*) }
	. = ALIGN(4);
	__rodata_end = .;

	__data_start = . ;
	.data : { *(.data*) }
	. = ALIGN(4);
	__data_end = . ;

	__bss_start = . ;
	.bss : { *(.bss*) }
	. = ALIGN(4);
	__bss_end = . ;
    
	. = ALIGN(4096);
	__free_start = .;
}