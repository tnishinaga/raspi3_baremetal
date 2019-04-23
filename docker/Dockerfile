FROM ubuntu:bionic
MAINTAINER Toshifumi NISHINAGA <tnishinaga.dev@gmail.com>

run echo "deb http://ja.archive.ubuntu.com/ubuntu bionic main universe" > /etc/apt/sources.list

RUN apt-get update \
    && apt-get -y install \
        cmake \
        ninja-build \
        curl \
        xz-utils \
        emacs-nox \
        vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# get aarch64 baremetal toolchain
RUN curl https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/8.3-2019.03/binrel/gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar.xz \
    | tar Jx -C /opt/
RUN ln -s /opt/gcc-arm-8.3-2019.03-x86_64-aarch64-elf /opt/aarch64-elf
ENV PATH $PATH:/opt/aarch64-elf/bin

RUN apt-get update \
    && apt-get -y install \
        qemu-system-arm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /home/work
WORKDIR /home/work

CMD ["/bin/bash"]
