# php-fpm/php-fpm.mk

PHP_FPM_NAME = php-fpm-alpine-ncc
PHP_FPM_PROJECT_PATH = $(PROJECT_PATH)/php-fpm

include php-fpm/_create-dockerfile.mk
include php-fpm/_create-docker-compose-yml.mk
include php-fpm/_docker-compose.mk

# test
include php-fpm/php-fpm-test/php-fpm-test.mk

_php-fpm-prepare:
	@echo "_php-fpm-prepare"
	mkdir -p $(PHP_FPM_PROJECT_PATH)

php-fpm-setup: _php-fpm-prepare
	@echo "php-fpm-setup"
	$(MAKE) _php-fpm/_create-dockerfile.mk
	$(MAKE) _php-fpm/_create-docker-compose-yml.mk
	$(MAKE) _php-fpm/_docker-compose.mk

php-fpm-up:
	@echo "php-fpm-up"
	$(MAKE) _php-fpm/_docker-compose.mk-up

php-fpm-down:
	@echo "php-fpm-down"
	$(MAKE) _php-fpm/_docker-compose.mk-down

php-fpm-down-v:
	@echo "php-fpm-down-v"
	$(MAKE) _php-fpm/_docker-compose.mk-down-v