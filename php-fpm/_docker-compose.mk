# php-fpm/_docker-compose.mk

PHP_FPM_DOCKER_COMPOSE_YML_FILES := $(PHP_FPM_PROJECT_PATH)/docker-compose.yml

_php-fpm/_docker-compose.mk:
	@echo "_php-fpm/_docker-compose.mk"
	make _php-fpm/_docker-compose.mk-create-docker-compose-yml


_php-fpm/_docker-compose.mk-create-docker-compose-yml:
	@echo "_php-fpm/_docker-compose.mk-create-docker-compose-yml"
	printf "$$PHP_FPM_DOCKER_COMPOSE_YML" > $(PHP_FPM_PROJECT_PATH)/docker-compose.yml
	printf "$$PHP_FPM_DOCKER_COMPOSE_YML_DEV" > $(PHP_FPM_PROJECT_PATH)/docker-compose.dev.yml
	printf "$$PHP_FPM_DOCKER_COMPOSE_YML_FEATURE" > $(PHP_FPM_PROJECT_PATH)/docker-compose.feature.yml
	printf "$$PHP_FPM_DOCKER_COMPOSE_YML_PROD" > $(PHP_FPM_PROJECT_PATH)/docker-compose.prod.yml

_php-fpm/_docker-compose.mk-up:
	@echo "_php-fpm/_docker-compose.mk-up"
	docker compose -f $(PHP_FPM_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(PHP_FPM_PROJECT_PATH) \
		up -d

_php-fpm/_docker-compose.mk-down:
	@echo "_php-fpm/_docker-compose.mk-down"
	docker compose -f $(PHP_FPM_DOCKER_COMPOSE_YML_FILES) \
		down

_php-fpm/_docker-compose.mk-down-v:
	@echo "_php-fpm/_docker-compose.mk-down-v"
	docker compose -f $(PHP_FPM_DOCKER_COMPOSE_YML_FILES) \
		down -v