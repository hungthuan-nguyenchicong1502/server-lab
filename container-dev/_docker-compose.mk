# container-dev/_docker-compose.mk

CONTAINER_DEV_DOCKER_COMPOSE_YML_FILES := $(CONTAINER_DEV_PROJECT_PATH)/docker-compose.yml
_container-dev/_docker-compose.mk:
	make _container-dev/_docker-compose.mk-create

_container-dev/_docker-compose.mk-create:
	printf "$$CONTAINER_DEV_DOCKER_COMPOSE_YML" > $(CONTAINER_DEV_PROJECT_PATH)/docker-compose.yml

_container-dev/_docker-compose.mk-up:
	docker compose -f $(CONTAINER_DEV_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(CONTAINER_DEV_PROJECT_PATH) \
		up -d

_container-dev/_docker-compose.mk-down:
	docker compose -f $(CONTAINER_DEV_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(CONTAINER_DEV_PROJECT_PATH) \
		down