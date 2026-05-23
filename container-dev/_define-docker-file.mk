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

CMD ["/usr/sbin/sshd", "-D"]
endef

export CONTAINER_DEV_DOCKER_FILE_FEATURE