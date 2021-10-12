#!/bin/bash
./rm.sh

docker run -d \
	-h "ctf" \
	--restart=always \
	--name "ctf" \
	-p 23946:23946 \
	-p 0.0.0.0:9595:22 \
	--cap-add=SYS_PTRACE \
	ctf
#-v $(pwd)/ctf:/ctf/work \
