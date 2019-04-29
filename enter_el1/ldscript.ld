OUTPUT_ARCH(aarch64)

ENTRY(_start)

MEMORY
{
	RAM(xrw) : ORIGIN = 0x80000 , LENGTH = (0x20000000 - 0x80000)
}

SECTIONS
{
	.text : {
		. = ALIGN(4);
		__text_start = .;
		_start = .;
		KEEP(*(.text.start))
		*(.text*)
		. = ALIGN(4);
		__text_end = .;
	} > RAM

	.rodata : {
		. = ALIGN(4);
		__rodata_start = .;
		*(.rodata*)
		. = ALIGN(4);
		__rodata_end = .;
	} > RAM

	.data : {
		. = ALIGN(4);
		__data_start = . ;
		*(.data*)
		. = ALIGN(4);
		__data_end = . ;
	} > RAM

	.bss : {
		. = ALIGN(4);
		__bss_start = . ;
		*(.bss*)
		. = ALIGN(4);
		__bss_end = . ;
	} > RAM

	.heap : {
		. = ALIGN(4);
		__heap_start = .;
		/* 64MiB heap */
		. = . + 1024 * 1024 * 64; 
		. = ALIGN(4);
		__heap_end = .;
	} > RAM
	
	.stack : {
		. = ALIGN(16);
		__stack_start = __stack_end - (1024*1024) * 64;
		
		/* 64MiB space */ 

		. = ALIGN(16);
		__stack_end = .;
	} > RAM
}