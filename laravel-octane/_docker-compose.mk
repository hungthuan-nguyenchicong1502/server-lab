# laravel-octane/_docker-compose.mk

_laravel-octane/_docker-compose.mk:
	@echo "_laravel-octane/_docker-compose.mk"
	$(MAKE) _laravel-octane/_docker-compose.mk-create-docker-file
	$(MAKE) _laravel-octane/_docker-compose.mk-create-docker-compose-yml
	$(MAKE) _laravel-octane/_docker-compose.mk-build

_laravel-octane/_docker-compose.mk-create-docker-file:
	@echo "_laravel-octane/_docker-compose.mk-create-docker-file"
	printf "$$LARAVEL_OCTANE_DOCKER_FILE" > $(LARAVEL_OCTANE_PROJECT_PATH)/Dockerfile

_laravel-octane/_docker-compose.mk-create-docker-compose-yml:
	@echo "_laravel-octane/_docker-compose.mk-create-docker-compose-yml"
	printf "$$LARAVEL_OCTANE_DOCKER_COMPOSE_YML" > $(LARAVEL_OCTANE_PROJECT_PATH)/docker-compose.yml

_laravel-octane/_docker-compose.mk-build:
	@echo "_laravel-octane/_docker-compose.mk-build"
	docker compose -f $(LARAVEL_OCTANE_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(LARAVEL_OCTANE_PROJECT_PATH) \
		up -d --build

_laravel-octane/_docker-compose.mk-up:
	@echo "_laravel-octane/_docker-compose.mk-up"
	docker compose -f $(LARAVEL_OCTANE_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(LARAVEL_OCTANE_PROJECT_PATH) \
		up -d

_laravel-octane/_docker-compose.mk-down:
	@echo "_laravel-octane/_docker-compose.mk-down"
	docker compose -f $(LARAVEL_OCTANE_PROJECT_PATH)/docker-compose.yml \
		down