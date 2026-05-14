# laravel/laravel.mk

LARAVEL_NAME = laravel-alpine-ncc
LARAVEL_PROJECT_PATH = $(PROJECT_PATH)/laravel
LARAVEL_VOLUMES_LARAVEL_APP = $(VOLUMES_PROJECT_APP)/laravel-app

LARAVEL_NAME_APP_ENV = $(LARAVEL_NAME)
ifeq ($(APP_ENV), dev)
	LARAVEL_NAME_APP_ENV := $(LARAVEL_NAME_APP_ENV)-dev
endif


include laravel/_define-dockerfile.mk
include laravel/_define-docker-compose-yml.mk
include laravel/_docker-compose.mk
include laravel/_create-laravel-app.mk

_laravel-prepare:
	@echo "_laravel-prepare"
	mkdir -p $(LARAVEL_PROJECT_PATH)
	mkdir -p $(LARAVEL_VOLUMES_LARAVEL_APP)

laravel-setup: _laravel-prepare
	@echo "laravel-setup"
	$(MAKE) _laravel/_docker-compose.mk
	$(MAKE) _laravel/_docker-compose.mk-build
	sleep 2;
	$(MAKE) _laravel/_create-laravel-app.mk

laravel-up:
	@echo "laravel-up"
	$(MAKE) _laravel/_docker-compose.mk-up

laravel-down:
	@echo "laravel-down"
	$(MAKE) _laravel/_docker-compose.mk-down

laravel-down-v:
	@echo "laravel-down-v"
	$(MAKE) _laravel/_docker-compose.mk-down-v

laravel-app-ls:
	ls $(LARAVEL_VOLUMES_LARAVEL_APP)