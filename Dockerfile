FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    supervisor \
    curl \
    wget \
    git \
    nano \
    vim \
    unzip \
    zip \
    htop \
    procps \
    net-tools \
    iputils-ping \
    ca-certificates \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Root password
RUN echo 'root:@Pablo123Vps' | chpasswd

# SSH configuration
RUN mkdir -p /run/sshd /var/log/supervisor && \
    sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?UsePAM.*/UsePAM no/' /etc/ssh/sshd_config

# Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Startup
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 22

CMD ["/start.sh"]
