# php-fpm/php-fpm-test/php-fpm-test.mk

PHP_FPM_TEXT_PROJECT_PATH := $(PHP_FPM_PROJECT_PATH)/php-fpm-test
PHP_FPM_TEXT_VOLUMES_PROJECT_APP := $(VOLUMES_PROJECT_APP_PATH)/php-fpm-test
PHP_FPM_TEXT_PATH := ./php-fpm/php-fpm-test

include php-fpm/php-fpm-test/_define-php-fpm-test-conf.mk

_php-fpm-test-prepare:
	mkdir -p $(PHP_FPM_TEXT_PROJECT_PATH)
	mkdir -p $(PHP_FPM_TEXT_VOLUMES_PROJECT_APP)

php-fpm-test: _php-fpm-test-prepare
	@echo "php-fpm-test"
	make nginx-test-remove
	make _php-fpm-test-create-php-fpm-test-conf
	sleep 1
	
	cp -f $(PHP_FPM_TEXT_PROJECT_PATH)/php-fpm-test.conf $(VOLUMES_NGINX_CONF)/php-fpm-test.conf
	cp -rf $(PHP_FPM_TEXT_PATH)/. $(PHP_FPM_TEXT_VOLUMES_PROJECT_APP)
	sleep 5
	make nginx-reload
# 	$(MAKE) php-fpm-restart

_php-fpm-test-create-php-fpm-test-conf:
	@echo "_php-fpm-test-create-php-fpm-test-conf"
	printf "$$PHP_FPM_TEST_CONF" > $(PHP_FPM_TEXT_PROJECT_PATH)/php-fpm-test.conf

php-fpm-test-remove:
	@echo "php-fpm-remove-test"
	rm -rf $(PHP_FPM_TEXT_VOLUMES_PROJECT_APP)
	rm -f $(NGINX_VOLUMES_CONF)/php-fpm-test.conf
