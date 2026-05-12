# z-git-dev/_laravel-app.mk
# LARAVEL_VOLUMES_LARAVEL_APP
_z-git-dev/_laravel-app.mk: _laravel-prepare
	@echo "z-git-dev/_laravel-app.mk"
	$(MAKE) _laravel/_docker-compose.mk
	$(MAKE) laravel-up
	sleep 2;
	$(MAKE) _laravel/_create-laravel-app.mk

test:
	ls $(LARAVEL_VOLUMES_LARAVEL_APP)