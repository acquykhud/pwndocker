FROM phusion/baseimage:master-amd64
MAINTAINER skysider <skysider@163.com>

ENV DEBIAN_FRONTEND noninteractive

ENV TZ Asia/Shanghai

RUN dpkg --add-architecture i386 && \
    apt-get -y update && \
    apt install -y \
    openssh-server \
    libc6:i386 \
    libc6-dbg:i386 \
    libc6-dbg \
    lib32stdc++6 \
    g++-multilib \
    cmake \
    ipython3 \
    vim \
    net-tools \
    iputils-ping \
    libffi-dev \
    libssl-dev \
    python3-dev \
    python3-pip \
    build-essential \
    ruby \
    ruby-dev \
    tmux \
    strace \
    ltrace \
    nasm \
    wget \
    gdb \
    gdb-multiarch \
    netcat \
    socat \
    git \
    patchelf \
    gawk \
    file \
    python3-distutils \
    bison \
    rpm2cpio cpio \
    zstd \
    tzdata --fix-missing \
    nano \
    htop \
    pypy3 \
    pypy3-dev \
    wget && \
    rm -rf /var/lib/apt/list/*

RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
    
RUN wget https://github.com/radareorg/radare2/releases/download/4.4.0/radare2_4.4.0_amd64.deb && \
    dpkg -i radare2_4.4.0_amd64.deb && rm radare2_4.4.0_amd64.deb

RUN pypy3 -m pip install -U pip && \
    pypy3 -m pip install --no-cache-dir \
    angr \
    ropgadget \
    pwntools \
    z3-solver \
    smmap2 \
    apscheduler \
    ropper \
    unicorn \
    keystone-engine \
    capstone \
    pycryptodome \
    pebble \
    jupyterlab \
    r2pipe

RUN gem install one_gadget seccomp-tools && rm -rf /var/lib/gems/2.*/cache/*

#RUN git clone --depth 1 https://github.com/niklasb/libc-database.git libc-database && \
#    cd libc-database && ./get ubuntu debian || echo "/libc-database/" > ~/.libcdb_path

WORKDIR /ctf/work/
COPY mpatch32 mpatch64 getsrc /usr/local/sbin/
RUN chmod +x /usr/local/sbin/*

COPY --from=skysider/glibc_builder64:2.27 /glibc/2.27/64 /glibc/2.27/64
COPY --from=skysider/glibc_builder32:2.27 /glibc/2.27/32 /glibc/2.27/32
RUN /usr/local/sbin/getsrc 2.27


COPY --from=skysider/glibc_builder64:2.31 /glibc/2.31/64 /glibc/2.31/64
COPY --from=skysider/glibc_builder32:2.31 /glibc/2.31/32 /glibc/2.31/32
RUN /usr/local/sbin/getsrc 2.31

#COPY linux_server linux_server64  /ctf/

#RUN chmod a+x /ctf/linux_server /ctf/linux_server64
RUN echo "root:1" | chpasswd
RUN useradd -d /home/user/ -m -p user -s /bin/bash user
RUN echo "user:user" | chpasswd
#CMD ["/sbin/my_init"]


RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "setw -g mouse on" >> /root/.tmux.conf
RUN /etc/init.d/ssh restart
CMD service ssh start && while true; do sleep 3000; done
