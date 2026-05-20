# laravel/laravel-test/laravel-test.mk

include laravel/laravel-test/_define-laravel-php-fpm-conf.mk
include laravel/laravel-test/_create-laravel-php-fpm-conf.mk
include laravel/laravel-test/_php-fpm-permission.mk

laravel-test-setup:
	@echo "laravel-test-setup"
	make php-fpm-test-remove
	make _laravel-test-create-laravel-php-fpm-conf
	sleep 1
	make _laravel/laravel-test/_php-fpm-permission.mk
	sleep 1
	make nginx-reload

laravel-test-remove:
	@echo "laravel-test-remove"
	rm -f $(LARAVEL_PROJECT_PATH)/laravel-php-fpm.conf
	rm -f $(NGINX_VOLUMES_CONF)/laravel-php-fpm.conf
