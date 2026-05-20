# php-fpm/php-fpm.mk

PHP_FPM_NAME = php-fpm-alpine-ncc
PHP_FPM_PROJECT_PATH = $(PROJECT_PATH)/php-fpm

PHP_FPM_NAME_APP_ENV := $(PHP_FPM_NAME)
PHP_FPM_WORKDIR_APP_ENV := /var/www/html

ifeq ($(APP_ENV), dev)
	PHP_FPM_NAME_APP_ENV := $(PHP_FPM_NAME)-dev
endif

ifeq ($(APP_ENV), feature)
	PHP_FPM_NAME_APP_ENV := $(PHP_FPM_NAME)-feature
	PHP_FPM_WORKDIR_APP_ENV := /home/project
endif

ifeq ($(APP_ENV), prod)
	PHP_FPM_NAME_APP_ENV := $(PHP_FPM_NAME)-prod
endif

include php-fpm/_define-docker-file.mk
include php-fpm/_define-docker-compose-yml.mk
include php-fpm/_docker-compose.mk

# test
include php-fpm/php-fpm-test/php-fpm-test.mk

# app-env-dev
include php-fpm/_app-env-dev/app-env-dev.mk

_php-fpm-prepare: _prepare
	@echo "_php-fpm-prepare"
	mkdir -p $(PHP_FPM_PROJECT_PATH)

php-fpm-setup: _php-fpm-prepare
	@echo "php-fpm-setup"
	$(MAKE) _php-fpm/_docker-compose.mk
	$(MAKE) app-env-dev-setup

php-fpm-up:
	@echo "php-fpm-up"
	$(MAKE) _php-fpm/_docker-compose.mk-up

php-fpm-down:
	@echo "php-fpm-down"
	$(MAKE) _php-fpm/_docker-compose.mk-down

php-fpm-down-v:
	@echo "php-fpm-down-v"
	$(MAKE) _php-fpm/_docker-compose.mk-down-v

php-fpm-restart:
	sleep 1;
	docker restart $(PHP_FPM_NAME_APP_ENV)
