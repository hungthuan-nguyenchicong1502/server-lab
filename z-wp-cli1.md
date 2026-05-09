docker exec -it wp-cli-alpine-ncc sh

# wp-cli/_create-dockerfile.mk

define WP_CLI_DOCKERFILE
FROM $(ALPINE_IMAGE)

RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.leaseweb.com/g' /etc/apk/repositories

RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache \
	php84 \
	composer

WORKDIR /app


_wp-cli-install:
	@echo "_wp-cli-install"
	$(MAKE) _wp-cli-create-use-db

_wp-cli-create-use-db:
	@echo "_wp-cli-create-use-db"
	@echo "check mariadb..."

	@i=0; while [ $$i -lt 15 ]; do \
		if docker exec $(MARIADB_NAME) mariadb-admin ping -h localhost --silent; then \
			echo "mariadb is ok:"; \
			break; \
		fi; \
		echo "Waiting... ($$i)"; \
		i=$$((i+1)); \
		sleep 2; \
	done

	docker exec -i $(MARIADB_NAME) mariadb -e \
		"CREATE DATABASE IF NOT EXISTS \`$(DB_NAME)\` CHARACTER SET $(DB_CHARSET) COLLATE $(DB_COLLATE); \
		CREATE USER IF NOT EXISTS '$(DB_USER)'@'%' IDENTIFIED BY '$(DB_PASSWORD)'; \
		GRANT ALL PRIVILEGES ON \`$(DB_NAME)\`.* TO '$(DB_USER)'@'%'; \
		FLUSH PRIVILEGES;"

# install wp-cli
RUN composer global require wp-cli/wp-cli-bundle && \
	ln -s ~/.composer/vendor/bin/wp /usr/bin/wp && \
	wp core download --path=$(WP_PATH)
# wp config shuffle-salts
RUN apk add --no-cache php84-tokenizer

COPY ./wp-config.php /app/$(WP_PATH)/wp-config.php

CMD ["sh", "-c", "tail -f /dev/null"]
endef

export WP_CLI_DOCKERFILE

_wp-cli-create-dockerfile:
	@echo "_wp-cli-create-dockerfile"
	echo "$$WP_CLI_DOCKERFILE" > $(WP_CLI_PROJECT_PATH)/Dockerfile

# learn
Dùng run: Khi bạn cần chạy một tác vụ một lần (one-off task). Ví dụ: docker-compose run --rm php composer install để cài đặt thư viện mà không muốn làm xáo trộn container chính đang chạy web.
# run

docker exec -it wp-cli-alpine-ncc sh

composer global require wp-cli/wp-cli-bundle

ln -s ~/.composer/vendor/bin/wp /usr/bin/wp

wp core download --path=wp-app

# test
wp core download --path=/wp-cli-test

ls /wp-cli-test