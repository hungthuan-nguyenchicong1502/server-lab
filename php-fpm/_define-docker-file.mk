# php-fpm/_define-docker-file.mk

# main
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

RUN chown -R nobody:nobody /var/log/php84 && \
    chmod -R 755  /var/log/php84

USER nobody

CMD ["php-fpm84", "-F"]
endef

export PHP_FPM_DOCKER_FILE


# dev
define PHP_FPM_DOCKER_FILE_DEV
FROM $(PHP_FPM_NAME)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" \\
	> /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache \
    php84-fpm \
    php84-ctype \
    php84-curl \
    php84-dom \
    php84-fileinfo \
    php84-gd \
    php84-gettext \
    php84-iconv \
    php84-intl \
    php84-mbstring \
    php84-openssl \
    php84-pdo \
    php84-pdo_mysql \
    php84-pdo_sqlite \
    php84-phar \
    php84-session \
    php84-tokenizer \
    php84-xml \
    php84-xmlreader \
    php84-xmlwriter \
    php84-zip \
    php84-zlib \
    php84-bcmath \
    php84-sodium

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php84/php-fpm.d/www.conf

RUN ln -sf /dev/stdout /var/log/php84/error.log

WORKDIR /var/www/html

RUN chown -R nobody:root /var/www/html /var/log/php84 && \
chmod -R 775 /var/www/html /var/log/php84

# CMD ["php-fpm84", "-F", "-R"]

CMD ["php-fpm84", "-F"]

endef

export PHP_FPM_DOCKER_FILE_DEV

# feature
define PHP_FPM_DOCKER_FILE_FEATURE
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

RUN chown -R nobody:nobody /var/log/php84 && \
    chmod -R 755  /var/log/php84

USER nobody

CMD ["php-fpm84", "-F"]

endef

export PHP_FPM_DOCKER_FILE_FEATURE

# prod
define PHP_FPM_DOCKER_FILE_PROD
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

RUN chown -R nobody:root /var/www/html /var/log/php84 && \
chmod -R 775 /var/www/html /var/log/php84

USER nobody

CMD ["php-fpm84", "-F"]

endef

export PHP_FPM_DOCKER_FILE_PROD
