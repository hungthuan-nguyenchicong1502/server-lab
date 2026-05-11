# php-fpm/_create-dockerfile.mk

define PHP_FPM_DOCKER_FILE
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" \\
	> /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache \
	php84-fpm \
	php84-mysqli \
	php84-gd

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php84/php-fpm.d/www.conf

RUN ln -sf /dev/stdout /var/log/php84/error.log

WORKDIR /var/www/html

RUN chown -R nobody:nobody /var/www/html /var/log/php84 && \
chmod -R 755 /var/www/html /var/log/php84

USER nobody

CMD ["php-fpm84", "-F"]

endef

export PHP_FPM_DOCKER_FILE

_php-fpm/_create-dockerfile.mk:
	@echo "_php-fpm/_create-dockerfile.mk"
	printf "$$PHP_FPM_DOCKER_FILE" > $(PHP_FPM_PROJECT_PATH)/Dockerfile