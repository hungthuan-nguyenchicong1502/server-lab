# laravel/_docker-compose.mk

LARAVEL_COMPOSE_FILES := -f $(LARAVEL_PROJECT_PATH)/docker-compose.yml

ifeq ($(APP_ENV), dev)
	LARAVEL_COMPOSE_FILES := -f $(LARAVEL_PROJECT_PATH)/docker-compose.dev.yml
endif
ifeq ($(APP_ENV), feature)
	LARAVEL_COMPOSE_FILES := -f $(LARAVEL_PROJECT_PATH)/docker-compose.feature.yml
endif

_laravel/_docker-compose.mk:
	@echo "_laravel/_docker-compose.mk"
	$(MAKE) _laravel/_docker-compose.mk-create-dockerfile
	$(MAKE) _laravel/_docker-compose.mk-create-docker-compose-yml

_laravel/_docker-compose.mk-create-dockerfile:
	@echo "_laravel/_docker-compose.mk-create-dockerfile"
	printf "$$LARAVEL_DOCKER_FILE" > $(LARAVEL_PROJECT_PATH)/Dockerfile
	printf "$$LARAVEL_DOCKER_FILE_DEV" > $(LARAVEL_PROJECT_PATH)/Dockerfile-dev
	printf "$$LARAVEL_DOCKER_FILE_FEATURE" > $(LARAVEL_PROJECT_PATH)/Dockerfile-feature

_laravel/_docker-compose.mk-create-docker-compose-yml:
	@echo "_laravel/_docker-compose.mk-create-docker-compose-yml"
	printf "$$LARAVEL_DOCKER_COMPOSE_YML" > $(LARAVEL_PROJECT_PATH)/docker-compose.yml
	printf "$$LARAVEL_DOCKER_COMPOSE_YML_DEV" > $(LARAVEL_PROJECT_PATH)/docker-compose.dev.yml
	printf "$$LARAVEL_DOCKER_COMPOSE_YML_FEATURE" > $(LARAVEL_PROJECT_PATH)/docker-compose.feature.yml

_laravel/_docker-compose.mk-build:
	@echo "_laravel/_docker-compose.mk-build"
	docker compose $(LARAVEL_COMPOSE_FILES) \
		--project-directory $(LARAVEL_PROJECT_PATH) \
		up -d --build

_laravel/_docker-compose.mk-up:
	@echo "_laravel/_docker-compose.mk-up"
	docker compose $(LARAVEL_COMPOSE_FILES) \
		--project-directory $(LARAVEL_PROJECT_PATH) \
		up -d

_laravel/_docker-compose.mk-down:
	@echo "_laravel/_docker-compose.mk-down"
	docker compose $(LARAVEL_COMPOSE_FILES) \
		down

_laravel/_docker-compose.mk-down-v:
	@echo "_laravel/_docker-compose.mk-down-v"
	docker compose $(LARAVEL_COMPOSE_FILES) \
		down -v