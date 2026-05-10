# laravel-octane/laravel-octane.mk

LARAVEL_OCTANE_NAME = laravel-octane-alpine-ncc
LARAVEL_OCTANE_REDIS_NAME = laravel-octane-redis-alpine-ncc
LARAVEL_OCTANE_PROJECT_PATH = $(PROJECT_PATH)/laravel-octane

include laravel-octane/_create-docker-file.mk
include laravel-octane/_create-docker-compose-yml.mk
include laravel-octane/_docker-compose.mk

_laravel-octane-prepare:
	@echo "_laravel-octane-prepare"
	mkdir -p $(LARAVEL_OCTANE_PROJECT_PATH)
	cp -f ./laravel-octane/laravel-octane.sh $(LARAVEL_OCTANE_PROJECT_PATH)
	cp -f ./laravel-octane/laravel-octane.conf $(NGINX_VOLUMES_CONF)

laravel-octane-setup: _laravel-octane-prepare
	@echo "laravel-octane-setup"
	$(MAKE) _laravel-octane/_create-docker-file.mk
	$(MAKE) _laravel-octane/_create-docker-compose-yml.mk
	$(MAKE) _laravel-octane/_docker-compose.mk

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
