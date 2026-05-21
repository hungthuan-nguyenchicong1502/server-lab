# wp-app/_wp-app-init.mk

include wp-app/_define-wp-app-conf.mk
include wp-app/_define-env-wp-app.mk
include wp-app/_create-connect-mariadb.mk

_wp-app/_wp-app-init.mk:
	@echo "wp-app/_wp-app-init.mk"
	$(MAKE) _wp-app/_wp-app-init.mk-create-wp-app-conf.mk
	$(MAKE) _wp-app/_wp-app-init.mk-create-env-wp-app.mk
	sleep 1;
	$(MAKE) _wp-app/_create-connect-mariadb.mk

	cp -f $(WP_APP_PROJECT_PATH)/wp-app.conf $(NGINX_VOLUMES_CONF)/wp-app.conf
	sleep 1;

_wp-app/_wp-app-init.mk-create-wp-app-conf.mk:
	@echo "_wp-app/_wp-app-init.mk-create-wp-app-conf.mk"
	@echo "create ./wp-app/wp-app.conf"
	printf "$$WP_APP_CONF" > $(WP_APP_PROJECT_PATH)/wp-app.conf
	sleep 1;

_wp-app/_wp-app-init.mk-create-env-wp-app.mk:
	@echo "_wp-app/_create-env-wp-app.mk"
	@echo "create ./wp-app/.env.wp-app"
	printf "$$WP_APP_ENV" > $(WP_APP_PROJECT_PATH)/.env.wp-app
	sleep 1;

test:
	cat $(WP_APP_PROJECT_PATH)/.env.wp-app