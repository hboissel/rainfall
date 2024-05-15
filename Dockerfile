FROM consol/debian-xfce-vnc

# Default dir is /root
WORKDIR /root
USER 0

RUN apt update

# install ssh client
RUN apt install -y openssh-client

# install JDK 17 64-bit
RUN apt install -y openjdk-17-jdk

# install ghidra
RUN apt install -y wget
RUN wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.0.3_build/ghidra_11.0.3_PUBLIC_20240410.zip
RUN apt install -y unzip
RUN unzip ghidra_11.0.3_PUBLIC_20240410.zip
RUN rm ghidra_11.0.3_PUBLIC_20240410.zip
# create symlink to ghidra
RUN ln -s /root/ghidra_11.0.3_PUBLIC/ghidraRun /usr/bin/ghidra

RUN apt install -y git

RUN wget https://github.com/pwndbg/pwndbg/releases/download/2024.02.14/pwndbg_2024.02.14_amd64.deb
RUN apt install ./pwndbg_2024.02.14_amd64.deb

RUN wget https://github.com/slimm609/checksec.sh/archive/refs/tags/2.7.0.zip
RUN unzip 2.7.0.zip
RUN rm 2.7.0.zip
RUN ln -s /root/checksec.sh-2.7.0/checksec /usr/bin/checksec
RUN apt install -y binutils
RUN apt install -y file

# Default command: open an interactive shell
CMD ["tail", "-f", "/dev/null" ]