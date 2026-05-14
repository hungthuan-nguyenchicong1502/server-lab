# php-fpm/_define-docker-file.mk

# main
define PHP_FPM_DOCKER_FILE
FROM $(ALPINE_IMAGE)

RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.leaseweb.com/g' /etc/apk/repositories


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


# dev
define PHP_FPM_DOCKER_FILE_DEV
FROM $(ALPINE_IMAGE)

RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.leaseweb.com/g' /etc/apk/repositories


RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache \
	php84-fpm \
	php84-mysqli \
	php84-gd

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php84/php-fpm.d/www.conf

RUN ln -sf /dev/stdout /var/log/php84/error.log

WORKDIR /var/www/html

RUN chown -R root:nobody /var/www/html /var/log/php84 && \
chmod -R 775 /var/www/html /var/log/php84

CMD ["php-fpm84", "-F", "-R"]

endef

export PHP_FPM_DOCKER_FILE_DEV
