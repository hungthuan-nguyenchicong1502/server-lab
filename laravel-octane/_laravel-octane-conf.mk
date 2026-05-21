# laravel-octane/_laravel-octane-conf.mk

_laravel-octane/_laravel-octane-conf.mk:
	@echo "laravel-octane/_laravel-octane-conf.mk"
	make laravel-octane/_laravel-octane-conf.mk-create

laravel-octane/_laravel-octane-conf.mk-create:
	@echo "laravel-octane/_laravel-octane-conf.mk-create"
	printf "$$LARAVEL_OCTANE_CONF" > $(LARAVEL_OCTANE_PROJECT_PATH)/laravel-octane.conf