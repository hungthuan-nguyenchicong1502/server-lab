# laravel-octane/laravel-octane.mk

LARAVEL_OCTANE_NAME = laravel-octane-alpine-ncc
LARAVEL_OCTANE_REDIS_NAME = laravel-octane-redis-alpine-ncc
LARAVEL_OCTANE_PROJECT_PATH = $(PROJECT_PATH)/laravel-octane

LARAVEL_OCTANE_APP_NAME := $(LARAVEL_OCTANE_NAME)
LARAVEL_OCTANE_REDIS_APP_NAME := $(LARAVEL_OCTANE_REDIS_NAME)

ifeq ($(APP_ENV), dev)
	LARAVEL_OCTANE_APP_NAME := $(LARAVEL_OCTANE_NAME)-dev
	LARAVEL_OCTANE_REDIS_APP_NAME :=$(LARAVEL_OCTANE_REDIS_NAME)-dev
endif

ifeq ($(APP_ENV), prod)
	LARAVEL_OCTANE_APP_NAME := $(LARAVEL_OCTANE_NAME)-prod
	LARAVEL_OCTANE_REDIS_APP_NAME :=$(LARAVEL_OCTANE_REDIS_NAME)-pro
endif

include laravel-octane/_define-laravel-octane-conf.mk
include laravel-octane/_define-docker-file.mk
include laravel-octane/_define-docker-compose-yml.mk
include laravel-octane/_docker-compose.mk

# test:
# 	@echo "$$LARAVEL_OCTANE_CONF"

_createlaravel-octane-conf:
	printf "$$LARAVEL_OCTANE_CONF" > $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.conf

_laravel-octane-prepare:
	@echo "_laravel-octane-prepare"
	mkdir -p $(LARAVEL_OCTANE_PROJECT_PATH)
	$(MAKE) _createlaravel-octane-conf
	cp -f ./laravel-octane/laravel-octane.sh $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.sh
	cp -f $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.conf $(NGINX_VOLUMES_CONF)/laravel-octane.conf

laravel-octane-setup: _laravel-octane-prepare
	@echo "laravel-octane-setup"
	$(MAKE) _laravel-octane/_docker-compose.mk
# 	$(MAKE) nginx-reload


laravel-octane-down:
	@echo "laravel-octane-down"
	$(MAKE) _laravel-octane/_docker-compose.mk-down

laravel-octane-up:
	@echo "laravel-octane-up"
	$(MAKE) _laravel-octane/_docker-compose.mk-up

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