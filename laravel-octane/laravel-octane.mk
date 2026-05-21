# laravel-octane/laravel-octane.mk

LARAVEL_OCTANE_NAME := laravel-octane-alpine-ncc
LARAVEL_OCTANE_REDIS_NAME := laravel-octane-redis-alpine-ncc
LARAVEL_OCTANE_PROJECT_PATH := $(PROJECT_PATH)/laravel-octane
LARAVEL_OCTANE_VERSION := v1.0.0
# Dockerfile
LARAVEL_OCTANE_IMAGE := $(LARAVEL_OCTANE_NAME)-$(LARAVEL_OCTANE_VERSION)
# docker-compose.yml
LARAVEL_OCTANE_NAME_APP_ENV := $(LARAVEL_OCTANE_NAME)-$(APP_ENV)
LARAVEL_OCTANE_NAME_REDIS_APP_ENV := $(LARAVEL_OCTANE_REDIS_NAME)-$(APP_ENV)
LARAVEL_OCTANE_WORKDIR := /laravel-app

ifeq ($(APP_ENV), dev)
	LARAVEL_OCTANE_NAME_APP_ENV := $(LARAVEL_OCTANE_NAME)-dev
	LARAVEL_OCTANE_NAME_REDIS_APP_ENV :=$(LARAVEL_OCTANE_REDIS_NAME)-dev
endif

ifeq ($(APP_ENV), feature)
	LARAVEL_OCTANE_WORKDIR := /home/project/laravel-app
endif

ifeq ($(APP_ENV), prod)
	LARAVEL_OCTANE_NAME_APP_ENV := $(LARAVEL_OCTANE_NAME)-prod
	LARAVEL_OCTANE_NAME_REDIS_APP_ENV :=$(LARAVEL_OCTANE_REDIS_NAME)-pro
endif

include laravel-octane/_define-docker-file.mk
include laravel-octane/_docker-file.mk
include laravel-octane/_define-docker-compose-yml.mk
include laravel-octane/_docker-compose.mk
include laravel-octane/_define-laravel-octane-conf.mk
include laravel-octane/_laravel-octane-conf.mk

# test:
# 	cat $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.conf

_laravel-octane-prepare: _prepare
	@echo "_laravel-octane-prepare"
	mkdir -p $(LARAVEL_OCTANE_PROJECT_PATH)
	cp -f ./laravel-octane/laravel-octane.sh $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.sh

laravel-octane-setup: _laravel-octane-prepare
	@echo "laravel-octane-setup"
	make _laravel-octane/_docker-file.mk
	make _laravel-octane/_docker-compose.mk
	make _laravel-octane/_laravel-octane-conf.mk
	sleep 1
	cp -f $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.conf $(NGINX_VOLUMES_CONF)/laravel-octane.conf
# 	sleep 5
# 	make nginx-reload

laravel-octane-build:
	@echo "laravel-octane-build"
	make _laravel-octane-docker-build

laravel-octane-down:
	@echo "laravel-octane-down"
	$(MAKE) _laravel-octane/_docker-compose.mk-down

laravel-octane-down-v:
	@echo "laravel-octane-down-v"
	$(MAKE) _laravel-octane/_docker-compose.mk-down-v

laravel-octane-up:
	@echo "laravel-octane-up"
	$(MAKE) _laravel-octane/_docker-compose.mk-up

laravel-octane-logs:
	docker logs $(LARAVEL_OCTANE_NAME_APP_ENV)

laravel-octane-cp-conf:
	@echo "laravel-octane-cp-conf"
	cp -f ./laravel-octane/laravel-octane.conf $(NGINX_VOLUMES_CONF)
	$(MAKE) nginx-reload

laravel-octane-rm-conf:
	@echo "laravel-octane-rm-conf"
	rm -f $(NGINX_VOLUMES_CONF)/laravel-octane.conf
	sleep 3
	make nginx-down
	sleep 1
	make nginx-up

laravel-octane-cat-conf:
	@echo "laravel-octane-cat-conf"
	cat $(NGINX_VOLUMES_CONF)/laravel-octane.conf