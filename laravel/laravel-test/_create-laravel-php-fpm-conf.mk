# laravel/laravel-test/_create-laravel-php-fpm-conf.mk

LARAVEL_PHP_FPM_CONF_SOURCE = $(LARAVEL_PROJECT_PATH)/laravel-php-fpm.conf
LARAVEL_PHP_FPM_CONF_TARGET = $(NGINX_VOLUMES_CONF)/laravel-php-fpm.conf


_laravel/laravel-test/_create-laravel-php-fpm-conf.mk:
	@echo "_laravel/laravel-test/_create-laravel-php-fpm-conf.mk"
	printf "$$LARAVEL_PHP_FPM_CONF" > $(LARAVEL_PHP_FPM_CONF_SOURCE)
	sleep 1
	cp -f $(LARAVEL_PHP_FPM_CONF_SOURCE) $(LARAVEL_PHP_FPM_CONF_TARGET)
	sleep 1

_laravel-test-create-laravel-php-fpm-conf:
	@echo "laravel-test-create-laravel-php-fpm-conf"
	make _laravel/laravel-test/_create-laravel-php-fpm-conf.mk


