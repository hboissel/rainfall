FROM ubuntu:latest

# Default dir is /root
WORKDIR /root
USER 0

RUN apt update

RUN apt install -y python3 python3-dev python3-pip openssh-client git unzip binutils ltrace file libc6-dev zsh libssl-dev libffi-dev build-essential
RUN apt-get install -y --fix-missing \
                            libxcb-xinerama0 \
                            libfontconfig \
                            libfreetype6 \
                            libglib2.0-0 \
                            libsm6 \
                            libssl-dev \
                            libstdc++6 \
                            libxext6 \
                            libxrender1 \
                            fontconfig \
                            libxrender1 \
                            libxtst6 \
                            libxi6 \
                            libsecret-1-0 libc6-dev-i386

RUN apt install -y wget
RUN wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
RUN tar -xvf Python-2.7.18.tgz
RUN cd Python-2.7.18 && ./configure && make && make install
RUN rm -rf Python-2.7.18.tgz Python-2.7.18

RUN chsh -s /bin/zsh
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

RUN wget https://github.com/slimm609/checksec.sh/archive/refs/tags/2.7.0.zip
RUN unzip 2.7.0.zip
RUN rm 2.7.0.zip
RUN ln -s /root/checksec.sh-2.7.0/checksec /usr/bin/checksec

# Install gdb
RUN apt install -y gdb

RUN wget https://github.com/pwndbg/pwndbg/releases/download/2024.02.14/pwndbg_2024.02.14_amd64.deb
RUN apt install ./pwndbg_2024.02.14_amd64.deb

RUN pip3 install pwntools --break-system-packages

# Default command: open an interactive shell
CMD ["tail", "-f", "/dev/null" ]