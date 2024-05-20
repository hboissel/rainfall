FROM consol/debian-xfce-vnc

# Default dir is /root
WORKDIR /root
USER 0

RUN apt update

# Install python3
RUN apt install -y python3 python3-dev python2 python3-pip openssh-client git unzip binutils ltrace file libc6-dev-i386 zsh libssl-dev libffi-dev build-essential

RUN chsh -s /bin/zsh
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

RUN wget https://github.com/slimm609/checksec.sh/archive/refs/tags/2.7.0.zip
RUN unzip 2.7.0.zip
RUN rm 2.7.0.zip
RUN ln -s /root/checksec.sh-2.7.0/checksec /usr/bin/checksec

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pwntools

# Install gdb
RUN apt install -y gdb

RUN wget https://github.com/pwndbg/pwndbg/releases/download/2024.02.14/pwndbg_2024.02.14_amd64.deb
RUN apt install ./pwndbg_2024.02.14_amd64.deb

# #Install IDA
# RUN wget https://out7.hex-rays.com/files/idafree70_linux.run
# RUN chmod +x idafree70_linux.run
# # Accept the license agreement
# RUN ./idafree70_linux.run

WORKDIR /headless
# Default command: open an interactive shell
CMD ["tail", "-f", "/dev/null" ]