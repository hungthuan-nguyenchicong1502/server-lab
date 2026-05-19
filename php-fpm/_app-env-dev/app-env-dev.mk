# php-fpm/_app-env-dev/app-env-dev.mk

LARAVEL_APP_DEV_CONF_SOURCE = $(PHP_FPM_PROJECT_PATH)/laravel-app-dev.conf
LARAVEL_APP_DEV_CONF_TARGET = $(NGINX_VOLUMES_CONF)/laravel-app-dev.conf

include php-fpm/_app-env-dev/_define-laravel-app-dev-conf.mk
include php-fpm/_app-env-dev/_create-laravel-app-dev-conf.mk

app-env-dev-setup:
	@echo "app-env-dev-setup"
	if [ $(APP_ENV) = 'dev' ]; then \
		make _create-laravel-app-dev-conf; \
		cp $(LARAVEL_APP_DEV_CONF_SOURCE) $(LARAVEL_APP_DEV_CONF_TARGET); \
		sleep 1; \
		make nginx-reload; \
	fi


