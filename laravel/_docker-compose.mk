# laravel/_docker-compose.mk

LARAVEL_DOCKER_COMPOSE_YML_FILES := $(LARAVEL_PROJECT_PATH)/docker-compose.yml

ifeq ($(APP_ENV), feature)
	LARAVEL_DOCKER_COMPOSE_YML_FILES := $(LARAVEL_PROJECT_PATH)/docker-compose.feature.yml
endif

_laravel/_docker-compose.mk:
	@echo "_laravel/_docker-compose.mk"
	make _laravel/_docker-compose.mk-create-docker-compose-yml

_laravel/_docker-compose.mk-create-docker-compose-yml:
	@echo "_laravel/_docker-compose.mk-create-docker-compose-yml"
	printf "$$LARAVEL_DOCKER_COMPOSE_YML" > $(LARAVEL_PROJECT_PATH)/docker-compose.yml
	printf "$$LARAVEL_DOCKER_COMPOSE_YML_DEV" > $(LARAVEL_PROJECT_PATH)/docker-compose.dev.yml
	printf "$$LARAVEL_DOCKER_COMPOSE_YML_FEATURE" > $(LARAVEL_PROJECT_PATH)/docker-compose.feature.yml

_laravel/_docker-compose.mk-build:
	@echo "_laravel/_docker-compose.mk-build"
	docker compose -f $(LARAVEL_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(LARAVEL_PROJECT_PATH) \
		build --no-cache

_laravel/_docker-compose.mk-up:
	@echo "_laravel/_docker-compose.mk-up"
	docker compose -f $(LARAVEL_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(LARAVEL_PROJECT_PATH) \
		up -d

_laravel/_docker-compose.mk-down:
	@echo "_laravel/_docker-compose.mk-down"
	docker compose -f $(LARAVEL_DOCKER_COMPOSE_YML_FILES) \
		down

_laravel/_docker-compose.mk-down-v:
	@echo "_laravel/_docker-compose.mk-down-v"
	docker compose -f $(LARAVEL_DOCKER_COMPOSE_YML_FILES) \
		down -v