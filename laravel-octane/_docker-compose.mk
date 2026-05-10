# laravel-octane/_docker-compose.mk

_laravel-octane/_docker-compose.mk:
	@echo "_laravel-octane/_docker-compose.mk"
	$(MAKE) _laravel-octane/_docker-compose.mk-build

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