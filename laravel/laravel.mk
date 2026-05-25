# laravel/laravel.mk

LARAVEL_NAME := laravel-alpine-ncc
LARAVEL_PROJECT_PATH := $(SHARE_PROJECT_PATH)/laravel
LARAVEL_NAME_VERSION := v1.0.0
# Dockerfile
# docker-compose.yml
LARAVEL_NAME_APP_ENV := $(LARAVEL_NAME)
LARAVEL_IMAGE := $(LARAVEL_NAME)-$(LARAVEL_NAME_VERSION)
LARAVEL_DOCKERFILE := Dockerfile.$(APP_ENV)
LARAVEL_WORKDIR := /home/project/laravel-app

# feature
ifeq ($(APP_ENV), feature)
 LARAVEL_PROJECT_PATH := $(PROJECT_PATH)/laravel
#  VOLUMES_LARAVEL_APP := $(LARAVEL_PROJECT_PATH)/volumes/laravel-app
endif

include laravel/_define-dockerfile.mk
include laravel/_docker-file.mk
include laravel/_define-docker-compose-yml.mk
include laravel/_docker-compose.mk
include laravel/_create-laravel-app.mk

# test
include laravel/laravel-test/laravel-test.mk

_laravel-prepare: _prepare
	@echo "_laravel-prepare"
	mkdir -p $(LARAVEL_PROJECT_PATH)

laravel-setup: _laravel-prepare
	@echo "laravel-setup"
	make _laravel/_docker-file.mk
	make _laravel/_docker-compose.mk
	sleep 1

laravel-create-laravel-app:
	@echo "laravel-create-laravel-app"
	make laravel-up
	sleep 1
	make _laravel/_create-laravel-app.mk
	sleep 1
	make laravel-down

laravel-build:
	@echo "laravel-build"
	make _laravel-docker-build
	sleep 1

laravel-up:
	@echo "laravel-up"
	make _laravel/_docker-compose.mk-up

laravel-down:
	@echo "laravel-down"
	make _laravel/_docker-compose.mk-down

laravel-down-v:
	@echo "laravel-down-v"
	make _laravel/_docker-compose.mk-down-v

# VOLUMES_LARAVEL_APP := $(VOLUMES_PROJECT_APP)/laravel-app
laravel-rm-volumes-laravel-app:
	@echo "laravel-rm-laravel-app"
	docker run -u root --rm -v $(VOLUMES_LARAVEL_APP):/parent $(ALPINE_IMAGE) sh -c "\
		chown -R root:root /parent; \
		chmod -R 777 /parent; \
		rm -rf /parent/laravel-app"
	rm -rf $(VOLUMES_LARAVEL_APP)

# LARAVEL_PROJECT_PATH
laravel-rm-laravel-project-path:
	make laravel-rm-laravel-app
	rm -rf $(LARAVEL_PROJECT_PATH)