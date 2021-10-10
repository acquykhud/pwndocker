#!/bin/bash

if [ $# -ne 1 ]; then
    echo "[+] Usage: getsrc <version>"
    echo "[+] Example: getsrc 2.31"
    exit;
fi;

wget http://mirrors.ustc.edu.cn/gnu/libc/glibc-${1}.tar.gz
tar -xf  glibc-${1}.tar.gz -C /
rm -f glibc-${1}.tar.gz

