# laravel/_docker-compose.mk

_laravel/_docker-compose.mk:
	@echo "_laravel/_docker-compose.mk"
	$(MAKE) _laravel/_docker-compose.mk-build

_laravel/_docker-compose.mk-build:
	@echo "_laravel/_docker-compose.mk-build"
	docker compose -f $(LARAVEL_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(LARAVEL_PROJECT_PATH) \
		up -d --build

_laravel/_docker-compose.mk-up:
	@echo "_laravel/_docker-compose.mk-up"
	docker compose -f $(LARAVEL_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(LARAVEL_PROJECT_PATH) \
		up -d

_laravel/_docker-compose.mk-down:
	@echo "_laravel/_docker-compose.mk-down"
	docker compose -f $(LARAVEL_PROJECT_PATH)/docker-compose.yml \
		down

_laravel/_docker-compose.mk-down-v:
	@echo "_laravel/_docker-compose.mk-down-v"
	docker compose -f $(LARAVEL_PROJECT_PATH)/docker-compose.yml \
		down -v