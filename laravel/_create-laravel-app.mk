# laravel/_create-laravel-app.mk

_laravel/_create-laravel-app.mk:
	@echo "_laravel/_create-laravel-app.mk"
	@docker exec -u root $(LARAVEL_NAME_APP_ENV) sh -c "\
		if [ ! -f $(LARAVEL_WORKDIR)/composer.json ]; then \
			composer create-project laravel/laravel:^12 $(LARAVEL_WORKDIR); \
		fi"