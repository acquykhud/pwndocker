#!/bin/bash

patch() {
	if [ ! -d "/glibc/$2" ]; then
		echo "[+] glibc ${2} not installed"
		exit 1
	fi
	patchelf --set-interpreter /glibc/$2/32/lib/ld-linux.so.2 --set-rpath /glibc/$2/32/lib/ $1
	echo "[+] Patch \"${1}\" to use glibc ${2} done"
	exit 0
}

if [ $# -ne 2 ]; then
	echo "[+] Usage: mpatch <executable> <version>"
	echo "[+] Example: mpatch ./myexec 2.27"
	exit 1
fi

patch $1 $2
