# php-fpm/_docker-compose.mk

_php-fpm/_docker-compose.mk:
	@echo "_php-fpm/_docker-compose.mk"
	$(MAKE) _php-fpm/_docker-compose.mk-build


_php-fpm/_docker-compose.mk-build:
	@echo "_php-fpm/_docker-compose.mk-build"
	docker compose -f $(PHP_FPM_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(PHP_FPM_PROJECT_PATH) \
		up -d --build

_php-fpm/_docker-compose.mk-up:
	@echo "_php-fpm/_docker-compose.mk-up"
	docker compose -f $(PHP_FPM_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(PHP_FPM_PROJECT_PATH) \
		up -d

_php-fpm/_docker-compose.mk-down:
	@echo "_php-fpm/_docker-compose.mk-down"
	docker compose -f $(PHP_FPM_PROJECT_PATH)/docker-compose.yml \
		down

_php-fpm/_docker-compose.mk-down-v:
	@echo "_php-fpm/_docker-compose.mk-down-v"
	docker compose -f $(PHP_FPM_PROJECT_PATH)/docker-compose.yml \
		down -v