# php-fpm/_app-env-dev/_create-laravel-app-dev-conf.mk


_create-laravel-app-dev-conf:
	@echo "_create-laravel-app-dev-conf"
	$(MAKE) _php-fpm/_app-env-dev/_create-laravel-app-dev-conf.mk

_php-fpm/_app-env-dev/_create-laravel-app-dev-conf.mk:
	@echo "php-fpm/_app-env-dev/_create-laravel-app-dev-conf.mk"
	printf "$$LARAVEL_APP_DEV_CONF" > $(LARAVEL_APP_DEV_CONF_SOURCE)
	sleep 1;