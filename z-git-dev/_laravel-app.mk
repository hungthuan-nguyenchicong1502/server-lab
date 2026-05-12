# z-git-dev/_laravel-app.mk
# LARAVEL_VOLUMES_LARAVEL_APP
_z-git-dev/_laravel-app.mk: _laravel-prepare
	@echo "z-git-dev/_laravel-app.mk"
	$(MAKE) _laravel/_docker-compose.mk
	$(MAKE) _laravel/_docker-compose.mk-build
# 	$(MAKE) _laravel/_docker-compose.mk-up
	sleep 2;
	$(MAKE) _z-git-dev/_laravel-app.mk-create-authorized-key
	$(MAKE) _laravel/_create-laravel-app.mk

_z-git-dev/_laravel-app.mk-create-authorized-key:
	@echo "_z-git-dev/_laravel-app.mk-create-authorized-key"
	docker exec $(LARAVEL_NAME_APP_ENV) sh -c "\
		printf '$(LARAVEL_DEV_AUTHORIZED_KEY)' > ~/.ssh/authorized_keys && \
		mkdir -p ~/.ssh && \
		chmod 700 ~/.ssh && \
		chmod 600 ~/.ssh/authorized_keys"


# test:
# 	ls $(LARAVEL_VOLUMES_LARAVEL_APP)