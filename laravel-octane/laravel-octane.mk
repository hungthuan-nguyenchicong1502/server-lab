# laravel-octane/laravel-octane.mk

LARAVEL_OCTANE_NAME := laravel-octane-alpine-ncc
LARAVEL_OCTANE_PROJECT_PATH := $(PROJECT_PATH)/laravel-octane
LARAVEL_OCTANE_VERSION := v1.0.0
# Dockerfile
LARAVEL_OCTANE_IMAGE := $(LARAVEL_OCTANE_NAME)-$(LARAVEL_OCTANE_VERSION)
# docker-compose.yml
LARAVEL_OCTANE_NAME_APP_ENV := $(LARAVEL_OCTANE_NAME)-$(APP_ENV)
LARAVEL_OCTANE_WORKDIR := $(LARAVEL_APP_PATH)

# feature
ifeq ($(APP_ENV), feature)
 LARAVEL_OCTANE_IMAGE := $(LARAVEL_OCTANE_NAME)-feature
endif

# include
include laravel-octane/_define-docker-file.mk
include laravel-octane/_docker-file.mk
include laravel-octane/_define-docker-compose-yml.mk
include laravel-octane/_docker-compose.mk
include laravel-octane/_define-laravel-octane-conf.mk
include laravel-octane/_laravel-octane-conf.mk
# setting
include laravel-octane/_laravel-octane-setting.mk
# create update
include laravel-octane/_laravel-octane-update.mk
# test:
# 	cat $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.conf

_laravel-octane-prepare: _prepare
	@echo "_laravel-octane-prepare"
	mkdir -p $(LARAVEL_OCTANE_PROJECT_PATH)
# 	cp -f ./laravel-octane/laravel-octane.sh $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.sh

laravel-octane-setup: _laravel-octane-prepare
	@echo "laravel-octane-setup"
	make _laravel-octane/_docker-file.mk
	make _laravel-octane/_docker-compose.mk
	make _laravel-octane/_laravel-octane-conf.mk

laravel-octane-build:
	@echo "laravel-octane-build"
	make _laravel-octane-docker-build

laravel-octane-setting:
	make _laravel-octane/_laravel-octane-setting.mk
	make _laravel-octane-conf-cp

laravel-octane-link-uploads:
	make _laravel-octane-setting-ls-sfn-uploads
	
laravel-octane-up:
	@echo "laravel-octane-up"
	make _laravel-octane/_docker-compose.mk-up

laravel-octane-down:
	@echo "laravel-octane-down"
	make _laravel-octane/_docker-compose.mk-down

laravel-octane-down-v:
	@echo "laravel-octane-down-v"
	make _laravel-octane/_docker-compose.mk-down-v

laravel-octane-update:
	@echo "make laravel-octane-update"
	make _laravel-octane/_laravel-octane-update.mk

laravel-octane-sh:
	docker exec -it $(LARAVEL_OCTANE_NAME_APP_ENV) sh

laravel-octane-restart:
	docker restart $(LARAVEL_OCTANE_NAME_APP_ENV)

laravel-octane-logs:
	docker logs $(LARAVEL_OCTANE_NAME_APP_ENV)

laravel-octane-rm-conf:
	@echo "laravel-octane-rm-conf"
	rm -f $(NGINX_VOLUMES_CONF)/laravel-octane.conf
	sleep 1
	make nginx-reload

laravel-octane-cat-conf:
	@echo "laravel-octane-cat-conf"
	cat $(NGINX_VOLUMES_CONF)/laravel-octane.conf