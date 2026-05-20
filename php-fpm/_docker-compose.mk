# php-fpm/_docker-compose.mk

PHP_FPM_COMPOSE_FILES := -f $(PHP_FPM_PROJECT_PATH)/docker-compose.yml

ifeq ($(APP_ENV), dev)
	PHP_FPM_COMPOSE_FILES := -f $(PHP_FPM_PROJECT_PATH)/docker-compose.dev.yml
endif

ifeq ($(APP_ENV), feature)
	PHP_FPM_COMPOSE_FILES := -f $(PHP_FPM_PROJECT_PATH)/docker-compose.feature.yml
endif

ifeq ($(APP_ENV), prod)
	PHP_FPM_COMPOSE_FILES := -f $(PHP_FPM_PROJECT_PATH)/docker-compose.prod.yml
endif

_php-fpm/_docker-compose.mk:
	@echo "_php-fpm/_docker-compose.mk"
	$(MAKE) _php-fpm/_docker-compose.mk-create-dockerfile
	$(MAKE) _php-fpm/_docker-compose.mk-create-docker-compose-yml
	$(MAKE) _php-fpm/_docker-compose.mk-build


_php-fpm/_docker-compose.mk-create-dockerfile:
	@echo "_php-fpm/_docker-compose.mk-create-dockerfile"
	printf "$$PHP_FPM_DOCKER_FILE" > $(PHP_FPM_PROJECT_PATH)/Dockerfile
	printf "$$PHP_FPM_DOCKER_FILE_DEV" > $(PHP_FPM_PROJECT_PATH)/Dockerfile.dev
	printf "$$PHP_FPM_DOCKER_FILE_FEATURE" > $(PHP_FPM_PROJECT_PATH)/Dockerfile.feature
	printf "$$PHP_FPM_DOCKER_FILE_PROD" > $(PHP_FPM_PROJECT_PATH)/Dockerfile.prod

_php-fpm/_docker-compose.mk-create-docker-compose-yml:
	@echo "_php-fpm/_docker-compose.mk-create-docker-compose-yml"
	printf "$$PHP_FPM_DOCKER_COMPOSE_YML" > $(PHP_FPM_PROJECT_PATH)/docker-compose.yml
	printf "$$PHP_FPM_DOCKER_COMPOSE_YML_DEV" > $(PHP_FPM_PROJECT_PATH)/docker-compose.dev.yml
	printf "$$PHP_FPM_DOCKER_COMPOSE_YML_FEATURE" > $(PHP_FPM_PROJECT_PATH)/docker-compose.feature.yml
	printf "$$PHP_FPM_DOCKER_COMPOSE_YML_PROD" > $(PHP_FPM_PROJECT_PATH)/docker-compose.prod.yml

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