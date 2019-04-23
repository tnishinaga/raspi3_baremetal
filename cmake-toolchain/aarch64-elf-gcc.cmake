set(A64PREFIX aarch64-elf)
set(CMAKE_C_COMPILER ${A64PREFIX}-gcc)
set(CMAKE_AR ${A64PREFIX}-ar CACHE FILEPATH "Arhiver")
set(CMAKE_RANLIB ${A64PREFIX}-ranlib CACHE FILEPATH "Ranlib")
set(CMAKE_AS ${A64PREFIX}-as)
set(CMAKE_NM ${A64PREFIX}-nm)
set(CMAKE_OBJDUMP ${A64PREFIX}-objdump)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

# sysroot
#set(CMAKE_SYSROOT /opt/aarch64-elf/)
#set(CMAKE_INCLUDE_PATH ${CMAKE_SYSROOT}/include)
#set(CMAKE_LIBRARY_PATH ${CMAKE_SYSROOT}/lib)
#set(CMAKE_FIND_ROOT_PATH ${CMAKE_SYSROOT})
#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
#set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# could not build shared library
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# initial CFLAGS
set(CMAKE_C_FLAGS_INIT "-nostartfiles -ffreestanding -fno-builtin -std=c11 -Wall -Wextra -Wl,-nodefaultlibs")