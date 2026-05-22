# container-dev/container-dev.mk

# CONTAINER_DEV
CONTAINER_DEV_NAME := container-dev-alpine-ncc
CONTAINER_DEV_PROJECT_PATH := $(PROJECT_PATH)/container-dev

# docker-compose-yml
CONTAINER_DEV_NAME_APP_ENV := $(CONTAINER_DEV_NAME)-$(APP_ENV)
CONTAINER_DEV_IMAGE := $(CONTAINER_DEV_NAME)

include container-dev/_define-docker-file.mk
include container-dev/_docker-file.mk
include container-dev/_define-docker-compose-yml.mk
include container-dev/_docker-compose.mk

_container-dev-setup-prepare: _prepare
	mkdir -p $(CONTAINER_DEV_PROJECT_PATH)

container-dev-setup: _container-dev-setup-prepare
	make _container-dev/_docker-file.mk
	make _container-dev/_docker-compose.mk
	sleep 1

container-dev-build:
	make _container-dev-docker-build

container-dev-up:
	make _container-dev/_docker-compose.mk-up

container-dev-down:
	make _container-dev/_docker-compose.mk-down

container-dev-logs:
	docker logs $(CONTAINER_DEV_NAME_APP_ENV)

container-dev-sh:
	docker exec -it $(CONTAINER_DEV_NAME_APP_ENV) sh