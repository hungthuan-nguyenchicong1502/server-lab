# laravel-octane/_define-docker-file.mk

# main
define LARAVEL_OCTANE_DOCKER_FILE
FROM $(LARAVEL_IMAGE)

RUN apk add --no-cache \
	php84-pecl-swoole \
    php84-pcntl \
    php84-posix \
	php84-tokenizer \
    php84-session

COPY ./laravel-octane.sh /usr/local/bin/laravel-octane.sh
RUN chmod +x /usr/local/bin/laravel-octane.sh

ENTRYPOINT ["/usr/local/bin/laravel-octane.sh"]

WORKDIR /laravel-app

CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=1000"]
# CMD ["sh", "-c", "tail -f >/dev/null"]
endef

export LARAVEL_OCTANE_DOCKER_FILE

# dev
define LARAVEL_OCTANE_DOCKER_FILE_DEV
FROM $(LARAVEL_NAME)

RUN apk add --no-cache \
	php84-pecl-swoole \
    php84-pcntl \
    php84-posix \
	php84-tokenizer \
    php84-session

COPY ./laravel-octane.sh /usr/local/bin/laravel-octane.sh
RUN chmod +x /usr/local/bin/laravel-octane.sh

ENTRYPOINT ["/usr/local/bin/laravel-octane.sh"]

WORKDIR /laravel-app

CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=1000"]
# CMD ["sh", "-c", "tail -f >/dev/null"]
endef

export LARAVEL_OCTANE_DOCKER_FILE_DEV

# feature
define LARAVEL_OCTANE_DOCKER_FILE_FEATURE
FROM $(LARAVEL_IMAGE)

RUN apk add --no-cache \
	php84-pecl-swoole \
    php84-pcntl \
    php84-posix \
	php84-tokenizer \
    php84-session

# COPY ./laravel-octane.sh /usr/local/bin/laravel-octane.sh
# RUN chmod +x /usr/local/bin/laravel-octane.sh

# ENTRYPOINT ["/usr/local/bin/laravel-octane.sh"]

WORKDIR $(LARAVEL_OCTANE_WORKDIR)

# install laravel octane
# RUN cd $(LARAVEL_OCTANE_WORKDIR) && \
#     composer require laravel/octane --quiet

EXPOSE 1000

CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=1000"]
# CMD ["sh", "-c", "tail -f >/dev/null"]
endef

export LARAVEL_OCTANE_DOCKER_FILE_FEATURE

# prod
define LARAVEL_OCTANE_DOCKER_FILE_PROD
FROM $(LARAVEL_NAME)

RUN apk add --no-cache \
	php84-pecl-swoole \
    php84-pcntl \
    php84-posix \
	php84-tokenizer \
    php84-session

COPY ./laravel-octane.sh /usr/local/bin/laravel-octane.sh
RUN chmod +x /usr/local/bin/laravel-octane.sh

ENTRYPOINT ["/usr/local/bin/laravel-octane.sh"]

WORKDIR /laravel-app

CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=1000"]
# CMD ["sh", "-c", "tail -f >/dev/null"]
endef

export LARAVEL_OCTANE_DOCKER_FILE_PROD