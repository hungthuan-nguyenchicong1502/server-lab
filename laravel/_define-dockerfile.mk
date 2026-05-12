# laravel/_define-dockerfile.mk

define LARAVEL_DOCKER_FILE
FROM $(ALPINE_IMAGE)

RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.leaseweb.com/g' /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache \
	php84 \
	composer

RUN apk add --no-cache \
    php84-tokenizer \
    php84-session \
    php84-dom \
    php84-xml \
    php84-xmlwriter \
    php84-fileinfo \
    php84-pdo \
    php84-pdo_sqlite \
    php84-pdo_mysql

# RUN composer create-project laravel/laravel:^12 laravel-app

CMD ["sh", "-c", "tail -f >/dev/nul"]
endef

export LARAVEL_DOCKER_FILE

define LARAVEL_DOCKER_FILE_DEV
FROM $(LARAVEL_NAME)

RUN apk add --no-cache \
    openssh \
    git \
    libgcc \
    libstdc++ \

RUN ssh-keygen -A

# vscode
RUN sed -i 's/AllowTcpForwarding.*/AllowTcpForwarding yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
#     sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
#     sed -i 's/#GatewayPorts.*/GatewayPorts yes/' /etc/ssh/sshd_config

WORKDIR /laravel-app

CMD ["/usr/sbin/sshd", "-D"]
endef

export LARAVEL_DOCKER_FILE_DEV