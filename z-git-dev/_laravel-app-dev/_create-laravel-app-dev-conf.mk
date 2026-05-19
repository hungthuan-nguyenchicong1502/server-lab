# z-git-dev/_laravel-app-dev/_create-laravel-app-dev-conf.mk

LARAVEL_APP_DEV_CONF_SOURCE = $(LARAVEL_PROJECT_PATH)/laravel-app-dev.conf
LARAVEL_APP_DEV_CONF_TARGET = $(NGINX_VOLUMES_CONF)/laravel-app-dev.conf

_z-git-dev/_laravel-app-dev/_create-laravel-app-dev-conf.mk:
	@echo "_z-git-dev/_laravel-app-dev/_create-laravel-app-dev-conf.mk"
# 	LARAVEL_APP_DEV_CONF
	printf "$$LARAVEL_APP_DEV_CONF" > $(LARAVEL_APP_DEV_CONF_SOURCE)
	sleep 1;

cp-laravel-dev-app-conf:
	@echo "cp-laravel-dev-app-conf"
	$(MAKE) _z-git-dev/_laravel-app-dev/_create-laravel-app-dev-conf.mk
	cp $(LARAVEL_APP_DEV_CONF_SOURCE) $(LARAVEL_APP_DEV_CONF_TARGET)
	sleep 1;
	$(MAKE) nginx-reload
