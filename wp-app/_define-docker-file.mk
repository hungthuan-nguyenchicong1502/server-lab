# wp-app/_define-docker-file.mk

# main
define WP_APP_DOCKER_FILE
FROM $(WP_CLI_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" \\
	> /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

CMD ["sh", "-c", "tail -f >/dev/null"]
endef
export WP_APP_DOCKER_FILE

#feature
define WP_APP_DOCKER_FILE_FEATURE
FROM $(WP_CLI_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" \\
	> /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

CMD ["sh", "-c", "tail -f >/dev/null"]
endef
export WP_APP_DOCKER_FILE_FEATURE