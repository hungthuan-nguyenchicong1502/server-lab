# laravel-octane/_docker-compose.mk

LARAVEL_OCTANE_COMPOSE_FILES := -f $(LARAVEL_OCTANE_PROJECT_PATH)/docker-compose.yml

ifeq ($(APP_ENV), feature)
	LARAVEL_OCTANE_COMPOSE_FILES := -f $(LARAVEL_OCTANE_PROJECT_PATH)/docker-compose.feature.yml
endif

_laravel-octane/_docker-compose.mk:
	@echo "_laravel-octane/_docker-compose.mk"
	$(MAKE) _laravel-octane/_docker-compose.mk-create-docker-file
	$(MAKE) _laravel-octane/_docker-compose.mk-create-docker-compose-yml
	$(MAKE) _laravel-octane/_docker-compose.mk-build

_laravel-octane/_docker-compose.mk-create-docker-file:
	@echo "_laravel-octane/_docker-compose.mk-create-docker-file"
	printf "$$LARAVEL_OCTANE_DOCKER_FILE" > $(LARAVEL_OCTANE_PROJECT_PATH)/Dockerfile
	printf "$$LARAVEL_OCTANE_DOCKER_FILE_FEATURE" > $(LARAVEL_OCTANE_PROJECT_PATH)/Dockerfile.feature

_laravel-octane/_docker-compose.mk-create-docker-compose-yml:
	@echo "_laravel-octane/_docker-compose.mk-create-docker-compose-yml"
	printf "$$LARAVEL_OCTANE_DOCKER_COMPOSE_YML" > $(LARAVEL_OCTANE_PROJECT_PATH)/docker-compose.yml
	printf "$$LARAVEL_OCTANE_DOCKER_COMPOSE_YML_FEATURE" > $(LARAVEL_OCTANE_PROJECT_PATH)/docker-compose.feature.yml

_laravel-octane/_docker-compose.mk-build:
	@echo "_laravel-octane/_docker-compose.mk-build"
	docker compose $(LARAVEL_OCTANE_COMPOSE_FILES) \
		--project-directory $(LARAVEL_OCTANE_PROJECT_PATH) \
		up -d --build

_laravel-octane/_docker-compose.mk-up:
	@echo "_laravel-octane/_docker-compose.mk-up"
	docker compose $(LARAVEL_OCTANE_COMPOSE_FILES) \
		--project-directory $(LARAVEL_OCTANE_PROJECT_PATH) \
		up -d

_laravel-octane/_docker-compose.mk-down:
	@echo "_laravel-octane/_docker-compose.mk-down"
	docker compose $(LARAVEL_OCTANE_COMPOSE_FILES) \
		down

_laravel-octane/_docker-compose.mk-down-v:
	@echo "_laravel-octane/_docker-compose.mk-down-v"
	docker compose $(LARAVEL_OCTANE_COMPOSE_FILES) \
		down -v