# redis/_docker-compose.mk

_redis/_docker-compose.mk:
	@echo "_redis/_docker-compose.mk"
	$(MAKE) _redis/_docker-compose.mk-build

_redis/_docker-compose.mk-build:
	@echo "_redis/_docker-compose.mk-build"
	docker compose -f $(REDIS_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(REDIS_PROJECT_PATH) \
		build