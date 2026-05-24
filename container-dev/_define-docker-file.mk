# container-dev/_define-docker-file.mk

define CONTAINER_DEV_DOCKER_FILE
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" \\
	> /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache \
	openssh \
	git \
	libgcc \
	libstdc++

RUN ssh-keygen -A

CMD ["/usr/sbin/sshd", "-D"]
endef

export CONTAINER_DEV_DOCKER_FILE

# feature
define CONTAINER_DEV_DOCKER_FILE_FEATURE
FROM $(CONTAINER_DEV_IMAGE_STABLE)

RUN apk add --no-cache \
	make

# vscode + root PermitRootLogin
RUN sed -i 's/AllowTcpForwarding.*/AllowTcpForwarding yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
# wp + laravel
RUN apk add --no-cache \
	php84 \
	composer \
	php84-tokenizer \
    php84-session \
    php84-dom \
    php84-xml \
    php84-xmlwriter \
    php84-fileinfo \
    php84-pdo \
    php84-pdo_sqlite \
    php84-pdo_mysql \
	php84-mysqli \
	php84-gd

# wp
RUN composer global require wp-cli/wp-cli-bundle && \
	ln -s ~/.composer/vendor/bin/wp /usr/bin/wp

# run container-dev.sh
COPY ./container-dev.sh /usr/local/bin/container-dev.sh
RUN chmod +x /usr/local/bin/container-dev.sh

ENTRYPOINT ["/usr/local/bin/container-dev.sh"]

# RUN composer create-project laravel/laravel:^12 laravel-app

# vscode
# apk update && apk add --no-cache \
#     libstdc++ \
#     gcompat \
#     icu-libs \
#     nodejs

CMD ["/usr/sbin/sshd", "-D"]
endef

export CONTAINER_DEV_DOCKER_FILE_FEATURE