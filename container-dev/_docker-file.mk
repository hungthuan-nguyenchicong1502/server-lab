# container-dev/_docker-file.mk
# CONTAINER_DEV_DOCKER_FILE
CONTAINER_DEV_DOCKER_FILE_FILES := $(CONTAINER_DEV_PROJECT_PATH)/Dockerfile

_container-dev/_docker-file.mk:
	make _container-dev/_docker-file.mk-create

_container-dev/_docker-file.mk-create:
	printf "$$CONTAINER_DEV_DOCKER_FILE" > $(CONTAINER_DEV_PROJECT_PATH)/Dockerfile

_container-dev-docker-build:
	docker build -t $(CONTAINER_DEV_IMAGE) \
		-f $(CONTAINER_DEV_DOCKER_FILE_FILES) \
		$(CONTAINER_DEV_PROJECT_PATH)
