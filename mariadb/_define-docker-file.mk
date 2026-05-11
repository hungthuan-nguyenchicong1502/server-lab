# mariadb/_define-docker-file.mk

# main

define MARIADB_DOCKER_FILE
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" \\
	> /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache \
	mariadb \
	mariadb-client

COPY ./mariadb.sh /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mariadbd", "--user=mysql", "--console", "--bind-address=0.0.0.0", "--skip-networking=0"]
endef

export MARIADB_DOCKER_FILE