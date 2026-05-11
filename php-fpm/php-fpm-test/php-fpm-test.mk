# php-fpm/php-fpm-test/php-fpm-test.mk

PHP_FPM_TEXT_PROJECT_PATH = $(PHP_FPM_PROJECT_PATH)/php-fpm-test
PHP_FPM_TEXT_VOLUMES_PROJECT_APP = $(VOLUMES_PROJECT_APP)/php-fpm-test
PHP_FPM_TEXT_PATH = ./php-fpm/php-fpm-test

include php-fpm/php-fpm-test/_define-php-fpm-test-conf.mk

test:
# 	ls $(PHP_FPM_TEXT_VOLUMES_PROJECT_APP)
# 	docker logs $(NGINX_NAME)-$(APP_ENV)
# 	docker exec -it $(NGINX_NAME)-$(APP_ENV) sh
# 	docker exec -it $(PHP_FPM_NAME)-$(APP_ENV) sh
# 	cat /etc/nginx/http.d/php-fpm-test.conf
# 	ls $(PHP_FPM_PROJECT_PATH)
# 	ls $(VOLUMES_PROJECT_APP)
# 	ls $(NGINX_PROJECT_PATH)
	ls $(VOLUMES_PROJECT)

_php-fpm-test-prepare:
	mkdir -p $(PHP_FPM_TEXT_PROJECT_PATH)
	mkdir -p $(PHP_FPM_TEXT_VOLUMES_PROJECT_APP)
	$(MAKE) _php-fpm-test-create-php-fpm-test-conf

php-fpm-test: _php-fpm-test-prepare
	@echo "php-fpm-test"
	$(MAKE) nginx-test-remove
	
	cp -f $(PHP_FPM_TEXT_PROJECT_PATH)/php-fpm-test.conf $(NGINX_VOLUMES_CONF)/php-fpm-test.conf
	cp -rf $(PHP_FPM_TEXT_PATH)/. $(PHP_FPM_TEXT_VOLUMES_PROJECT_APP)

	sleep 1;
	docker restart $(PHP_FPM_NAME)-$(APP_ENV)
	docker restart $(NGINX_NAME)-$(APP_ENV)

_php-fpm-test-create-php-fpm-test-conf:
	@echo "_php-fpm-test-create-php-fpm-test-conf"
	printf "$$PHP_FPM_TEST_CONF" > $(PHP_FPM_TEXT_PROJECT_PATH)/php-fpm-test.conf

php-fpm-test-remove:
	@echo "php-fpm-test-remove"
	rm -rf $(PHP_FPM_TEXT_VOLUMES_PROJECT_APP)
	rm -f $(NGINX_VOLUMES_CONF)/php-fpm-test.conf
