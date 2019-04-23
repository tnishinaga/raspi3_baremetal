#!/bin/sh

cmake -H. -Bcmake_workdir -GNinja -DCMAKE_TOOLCHAIN_FILE=../cmake-toolchain/aarch64-elf-gcc.cmake
cmake --build cmake_workdir/