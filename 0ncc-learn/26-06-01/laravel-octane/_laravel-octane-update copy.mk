# laravel-octane/_laravel-octane-update.mk

_laravel-octane/_laravel-octane-update.mk:
	make _laravel-octane/_laravel-octane-update.mk-update

_laravel-octane/_laravel-octane-update.mk-update:
	docker run --rm \
		--network=$(MY_APP_NET) \
		-v $(VOLUMES_LARAVEL_APP):$(LARAVEL_OCTANE_WORKDIR) \
		-v $(VOLUMES_CONTAINER_GIT_CLONE):$(CONTAINER_GIT_CLONE_WORKDIR) \
		-w $(LARAVEL_OCTANE_WORKDIR) \
		$(LARAVEL_OCTANE_IMAGE) sh -c "\
			composer require laravel/octane --quiet; \
			composer update; \
			composer dump-autoload; \
			php artisan migrate; \
			php artisan optimize:clear"