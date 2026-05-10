# laravel-octane/_create-docker-file.mk

define LARAVEL_OCTANE_DOCKER_FILE
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

export LARAVEL_OCTANE_DOCKER_FILE

_laravel-octane/_create-docker-file.mk:
	@echo "_laravel-octane/_create-docker-file.mk"
	printf "$$LARAVEL_OCTANE_DOCKER_FILE" > $(LARAVEL_OCTANE_PROJECT_PATH)/Dockerfile