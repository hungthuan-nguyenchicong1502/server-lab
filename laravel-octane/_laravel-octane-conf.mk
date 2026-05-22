# laravel-octane/_laravel-octane-conf.mk

_laravel-octane/_laravel-octane-conf.mk:
	@echo "laravel-octane/_laravel-octane-conf.mk"
	make _laravel-octane/_laravel-octane-conf.mk-create

_laravel-octane/_laravel-octane-conf.mk-create:
	@echo "laravel-octane/_laravel-octane-conf.mk-create"
	printf "$$LARAVEL_OCTANE_CONF" > $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.conf

_laravel-octane-conf-cp:
	@echo "_laravel-octane-conf-cp"
	cp -f $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.conf $(VOLUMES_NGINX_CONF)/laravel-octane.conf
