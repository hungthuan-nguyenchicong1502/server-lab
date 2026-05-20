# laravel/_create-laravel-app.mk

_laravel/_create-laravel-app.mk:
	@echo "_laravel/_create-laravel-app.mk"
	@docker exec $(LARAVEL_NAME_APP_ENV) sh -c "\
		if [ ! -f /laravel-app/composer.json ]; then \
			composer create-project laravel/laravel:^12 $(LARAVEL_WORKDIR_APP_ENV); \
		fi"