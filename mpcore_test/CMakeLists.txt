cmake_minimum_required(VERSION 3.10)
project(kernel)

enable_language(ASM C)

add_executable(kernel start.S main.c)

# add linkerscript
set(LINKER_SCRIPT "ldscript.ld")
set_target_properties(kernel PROPERTIES LINK_DEPENDS ${CMAKE_SOURCE_DIR}/${LINKER_SCRIPT})
