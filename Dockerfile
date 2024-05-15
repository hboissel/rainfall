FROM ubuntu:latest

# Default dir is /root
WORKDIR /root

# Update package list
RUN apt-get update

# Install ssh client
RUN apt-get install -y openssh-client

# Install tmux
RUN apt-get install -y tmux


# Default command: open an interactive shell
CMD ["tail", "-f", "/dev/null" ]