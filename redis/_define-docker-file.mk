# redis/_define-docker-file.mk

define REDIS_DOCKER_FILE
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" \\
	> /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache redis

RUN sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis.conf && \
    sed -i 's/protected-mode yes/protected-mode no/g' /etc/redis.conf

CMD ["redis-server", "/etc/redis.conf"]
endef

export REDIS_DOCKER_FILE