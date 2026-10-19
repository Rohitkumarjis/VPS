FROM ubuntu:22.04

# Update aur SSH Server + basic tools install karna
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    git \
    nano \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# SSH run directory create karna
RUN mkdir /var/run/sshd

# User banana (yahan 'ajit' ki jagah jo naam chahein rakh sakte hain)
RUN useradd -rm -d /home/ajit -s /bin/bash -g root -G sudo -u 1000 ajit

# Password set karna (yahan 'ajit1234' ki jagah apna strong password daalein)
RUN echo 'ajit:ajit1234' | chpasswd

# Root login block aur normal password login allow karna
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# SSH port expose karna
EXPOSE 22

# Container start hote hi SSH service run karna
CMD ["/usr/sbin/sshd", "-D"]
