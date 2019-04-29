#!/bin/sh

cmake -H. -Bcmake_workdir -GNinja -DCMAKE_TOOLCHAIN_FILE=../cmake-toolchain/aarch64-elf-gcc.cmake -DCMAKE_BUILD_TYPE=DEBUG
cmake --build cmake_workdir/