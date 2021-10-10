#!/bin/bash
./rm.sh

docker run -d \
	-h "ctf" \
	--restart=always \
	--name "ctf" \
	-p 23946:23946 \
	-p 9595:22 \
	--cap-add=SYS_PTRACE \
	ctf
#-v $(pwd)/ctf:/ctf/work \
