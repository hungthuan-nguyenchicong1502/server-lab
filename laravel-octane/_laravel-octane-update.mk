# laravel-octane/_laravel-octane-update.mk

_laravel-octane/_laravel-octane-update.mk:
	make _laravel-octane/_laravel-octane-update.mk-update

_laravel-octane/_laravel-octane-update.mk-update:
	@echo "_laravel-octane/_laravel-octane-update.mk-update"
	make packages-ncc-git-pull
	docker exec $(LARAVEL_OCTANE_NAME_APP_ENV) sh -c "\
		composer install --no-dev --optimize-autoloader; \
		php artisan migrate; \
		php artisan build-ncc -f; \
		php artisan optimize:clear; \
		php artisan octane:reload"

	make laravel-octane-restart
	sleep 3
	make nginx-reload