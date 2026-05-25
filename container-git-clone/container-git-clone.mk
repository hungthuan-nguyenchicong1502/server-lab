# container-git-clone/container-git-clone.mk
# CONTAINER_GIT_CLONE
CONTAINER_GIT_CLONE_NAME := container-git-clone-apline-ncc
CONTAINER_GIT_CLONE_PROJECT_PATH := $(PROJECT_PATH)/container-git-clone

# build
CONTAINER_GIT_CLONE_VERSION := v1.0.0
CONTAINER_GIT_CLONE_IMAGE := $(CONTAINER_GIT_CLONE_NAME)-$(CONTAINER_GIT_CLONE_VERSION)
# docker-compose.yml
CONTAINER_GIT_CLONE_NAME_APP_ENV := $(CONTAINER_GIT_CLONE_NAME)-$(APP_ENV)
# VOLUMES_PROJECT_APP_PATH
VOLUMES_CONTAINER_GIT_CLONE := $(VOLUMES_PROJECT_APP_PATH)
CONTAINER_GIT_CLONE_WORKDIR := /home/project

include container-git-clone/_container-git-clone-sh-cp.mk
include container-git-clone/_define-docker-file.mk
include container-git-clone/_docker-file.mk
include container-git-clone/_defile-docker-compose-yml.mk
include container-git-clone/_docker-compose-yml.mk

_container-git-clone-prepare: _prepare
	mkdir -p $(CONTAINER_GIT_CLONE_PROJECT_PATH)

container-git-clone-setup: _container-git-clone-prepare
	make _container-git-clone/_container-git-clone-sh-cp.mk
	make _container-git-clone/_docker-file.mk
	make _container-git-clone/_docker-compose-yml.mk

container-git-clone-build:
	make _container-git-clone-docker-build

container-git-clone-up:
	make _container-git-clone/_docker-compose-yml.mk-up

container-git-clone-down:
	make _container-git-clone/_docker-compose-yml.mk-down

container-git-clone-sh:
	docker exec -it $(CONTAINER_GIT_CLONE_NAME_APP_ENV) sh -l