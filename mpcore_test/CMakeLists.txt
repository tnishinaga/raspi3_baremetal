cmake_minimum_required(VERSION 3.10)
project(kernel.elf)

enable_language(ASM C)

add_executable(kernel.elf start.S main.c arm_pl011.c arm_pl011.h)

set(CMAKE_C_FLAGS_DEBUG "-g3")

# add linkerscript
set(LINKER_SCRIPT "ldscript.ld")
set_target_properties(kernel.elf PROPERTIES LINK_DEPENDS ${CMAKE_SOURCE_DIR}/${LINKER_SCRIPT})
target_link_libraries(kernel.elf PUBLIC -T${CMAKE_SOURCE_DIR}/${LINKER_SCRIPT})
# static link
target_link_libraries(kernel.elf PUBLIC -static)
# output map file
target_link_libraries(kernel.elf PUBLIC -Wl,-Map=kernel.map)


# copy to binary
add_custom_command(
   TARGET kernel.elf
   POST_BUILD
   WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
   COMMAND ${CMAKE_OBJCOPY} -O binary kernel.elf kernel.bin
)
