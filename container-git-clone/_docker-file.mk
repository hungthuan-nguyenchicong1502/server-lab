# container-git-clone/_docker-file.mk

_container-git-clone/_docker-file.mk:
	make _container-git-clone/_docker-file.mk-create

_container-git-clone/_docker-file.mk-create:
	printf "$$CONTAINER_GIT_CLONE_DOCKER_FILE" > $(CONTAINER_GIT_CLONE_PROJECT_PATH)/Dockerfile

_container-git-clone-docker-build:
	docker build -t $(CONTAINER_GIT_CLONE_IMAGE) \
		-f $(CONTAINER_GIT_CLONE_PROJECT_PATH)/Dockerfile \
		$(CONTAINER_GIT_CLONE_PROJECT_PATH)