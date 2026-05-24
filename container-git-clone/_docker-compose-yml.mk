# container-git-clone/_docker-compose-yml.mk
# CONTAINER_GIT_CLONE_DOCKER_COMPOSE_YML

CONTAINER_GIT_CLONE_DOCKER_COMPOSE_YML_FILES := $(CONTAINER_GIT_CLONE_PROJECT_PATH)/docker-compose.yml

_container-git-clone/_docker-compose-yml.mk:
	make _container-git-clone/_docker-compose-yml.mk-create

_container-git-clone/_docker-compose-yml.mk-create:
	printf "$$CONTAINER_GIT_CLONE_DOCKER_COMPOSE_YML" > $(CONTAINER_GIT_CLONE_PROJECT_PATH)/docker-compose.yml

_container-git-clone/_docker-compose-yml.mk-up:
	docker compose -f $(CONTAINER_GIT_CLONE_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(CONTAINER_GIT_CLONE_PROJECT_PATH) \
		up -d

_container-git-clone/_docker-compose-yml.mk-down:
	docker compose -f $(CONTAINER_GIT_CLONE_DOCKER_COMPOSE_YML_FILES) \
		down