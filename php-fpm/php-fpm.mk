# php-fpm/php-fpm.mk

PHP_FPM_NAME = php-fpm-alpine-ncc
PHP_FPM_PROJECT_PATH = $(PROJECT_PATH)/php-fpm
PHP_FPM_VERSION := v.1.0.0
# Dockerfile
PHP_FPM_WORKDIR := /var/www/html
# docker-compose.yml
PHP_FPM_NAME_APP_ENV := $(PHP_FPM_NAME)-$(APP_ENV)
PHP_FPM_DOCKERFILE := Dockerfile.$(APP_ENV)
PHP_FPM_IMAGE := $(PHP_FPM_NAME_APP_ENV)-$(PHP_FPM_VERSION)

ifeq ($(APP_ENV), feature)
	PHP_FPM_WORKDIR := /home/project
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
# 	$(MAKE) app-env-dev-setup

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
