# laravel/laravel-test/_php-fpm-permission.mk

_laravel/laravel-test/_php-fpm-permission.mk:
		docker exec -u root $(PHP_FPM_NAME_APP_ENV) sh -c "\
			chown -R root:nobody $(LARAVEL_WORKDIR_APP_ENV); \
			chmod -R 775 $(LARAVEL_WORKDIR_APP_ENV)"
