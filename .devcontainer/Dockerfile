FROM ubuntu:26.04
ENV DEBIAN_FRONTEND=noninteractive

ARG TOOLCHAIN=gcc
ARG CLANGD_VERSION=22
ARG VERSION=15

RUN apt-get update && apt-get install -y \
    sudo curl git cmake ninja-build lsb-release software-properties-common wget \
    zip unzip pkg-config build-essential tar bzip2 \
    && rm -rf /var/lib/apt/lists/*


RUN if [ "$TOOLCHAIN" = "llvm" ]; then \
    wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh \
    && ./llvm.sh ${VERSION} \
    && apt-get update && apt-get install -y \
    clang-${VERSION} \
    clangd-${VERSION} \
    clang-tidy-${VERSION} \
    && rm llvm.sh \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${VERSION} 100 \
    --slave /usr/bin/clang++ clang++ /usr/bin/clang++-${VERSION} \
    --slave /usr/bin/clangd clangd /usr/bin/clangd-${VERSION} \
    --slave /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-${VERSION} \
    && update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100; \
    else \
    wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh \
    && ./llvm.sh ${CLANGD_VERSION} \
    && apt-get update && apt-get install -y \
    gcc-${VERSION} \
    g++-${VERSION} \
    clangd-${CLANGD_VERSION} \
    && rm llvm.sh \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${VERSION} 100 \
    --slave /usr/bin/g++ g++ /usr/bin/g++-${VERSION} \
    && update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 100 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-${CLANGD_VERSION} 100; \
    fi \
    && rm -rf /var/lib/apt/lists/* 

RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

RUN git clone --branch 2026.06.24 --depth 1 https://github.com/microsoft/vcpkg.git /home/ubuntu/vcpkg \
    && /home/ubuntu/vcpkg/bootstrap-vcpkg.sh

ENV VCPKG_ROOT="/home/ubuntu/vcpkg"
ENV PATH="${VCPKG_ROOT}:${PATH}"
