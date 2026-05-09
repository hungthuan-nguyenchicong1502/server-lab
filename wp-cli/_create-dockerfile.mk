# wp-cli/_create-dockerfile.mk

define WP_CLI_DOCKER_FILE
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" \\
	> /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache \
	php84 \
	composer \
	php84-mysqli \
	php84-tokenizer \
	mariadb-client

RUN composer global require wp-cli/wp-cli-bundle && \
	ln -s ~/.composer/vendor/bin/wp /usr/bin/wp

CMD ["sh", "-c", "tail -f >/dev/null"]
endef

export WP_CLI_DOCKER_FILE

_wp-cli/_create-dockerfile.mk:
	@echo "_wp-cli/_create-dockerfile.mk"
	printf "$$WP_CLI_DOCKER_FILE" > $(WP_CLI_PROJECT_PATH)/Dockerfile