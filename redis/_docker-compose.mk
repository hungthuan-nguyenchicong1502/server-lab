# redis/_docker-compose.mk

REDIS_DOCKER_COMPOSE_YML_FILES = $(REDIS_PROJECT_PATH)/docke-compose.yml

_redis/_docker-compose.mk:
	@echo "_redis/_docker-compose.mk"
	make _redis/_docker-compose.mk-create

_redis/_docker-compose.mk-create:
	@echo "_redis/_docker-compose.mk"
	printf "$$REDIS_DOCKER_COMPOSE_YML" > $(REDIS_PROJECT_PATH)/docke-compose.yml

_redis/_docker-compose.mk-build:
	@echo "_redis/_docker-compose.mk-build"
	docker compose -f $(REDIS_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(REDIS_PROJECT_PATH) \
		build

_redis/_docker-compose.mk-up:
	@echo "_redis/_docker-compose.mk-up"
	docker compose -f $(REDIS_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(REDIS_PROJECT_PATH) \
		up -d

_redis/_docker-compose.mk-down:
	@echo "_redis/_docker-compose.mk-down"
	docker compose -f $(REDIS_DOCKER_COMPOSE_YML_FILES) \
		down