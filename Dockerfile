FROM consol/debian-xfce-vnc

# Default dir is /root
WORKDIR /root
USER 0

RUN apt update

# Install python3
RUN apt install -y python3 python2
RUN apt install -y python3-pip

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

#install visual studio code

RUN apt install -y curl
RUN wget https://go.microsoft.com/fwlink/?LinkID=760868 -O code.deb
RUN apt install -y ./code.deb

COPY binary_exploitation_101 /root/binary_exploitation_101

# Install libc
RUN apt install -y libc6-dev-i386

# Install ltrace
RUN apt install -y ltrace

# Install zsh
RUN apt install -y zsh
RUN chsh -s /bin/zsh
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

RUN apt install -y python3-dev git libssl-dev libffi-dev build-essential
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pwntools

# Default command: open an interactive shell
CMD ["tail", "-f", "/dev/null" ]