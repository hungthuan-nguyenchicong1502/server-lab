# php-fpm/_docker-compose.mk

PHP_FPM_COMPOSE_FILES := -f $(PHP_FPM_PROJECT_PATH)/docker-compose.yml

ifeq ($(APP_ENV), dev)
	PHP_FPM_COMPOSE_FILES += -f $(PHP_FPM_PROJECT_PATH)/docker-compose.override.yml
endif

_php-fpm/_docker-compose.mk:
	@echo "_php-fpm/_docker-compose.mk"
	$(MAKE) _php-fpm/_docker-compose.mk-build


_php-fpm/_docker-compose.mk-build:
	@echo "_php-fpm/_docker-compose.mk-build"
	docker compose $(PHP_FPM_COMPOSE_FILES) \
		--project-directory $(PHP_FPM_PROJECT_PATH) \
		up -d --build

_php-fpm/_docker-compose.mk-up:
	@echo "_php-fpm/_docker-compose.mk-up"
	docker compose $(PHP_FPM_COMPOSE_FILES) \
		--project-directory $(PHP_FPM_PROJECT_PATH) \
		up -d

_php-fpm/_docker-compose.mk-down:
	@echo "_php-fpm/_docker-compose.mk-down"
	docker compose $(PHP_FPM_COMPOSE_FILES) \
		down

_php-fpm/_docker-compose.mk-down-v:
	@echo "_php-fpm/_docker-compose.mk-down-v"
	docker compose $(PHP_FPM_COMPOSE_FILES) \
		down -v