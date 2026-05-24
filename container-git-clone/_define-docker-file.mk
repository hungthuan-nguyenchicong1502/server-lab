# container-git-clone/_define-docker-file.mk

define CONTAINER_GIT_CLONE_DOCKER_FILE
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" \\
	> /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache \
	openssh-client \
	git

RUN ssh-keygen -A

COPY ./container-git-clone.sh /usr/local/bin/container-git-clone.sh
RUN chmod +x /usr/local/bin/container-git-clone.sh

ENTRYPOINT ["/usr/local/bin/container-git-clone.sh"]

CMD ["sh", "-c", "tail -f > /dev/null"]
endef
export CONTAINER_GIT_CLONE_DOCKER_FILE