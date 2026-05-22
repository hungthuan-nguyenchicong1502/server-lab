# wp-app/_wp-app-conf.mk

_wp-app/_wp-app-conf.mk:
	@echo "wp-app/_wp-app-conf.mk"
	make _wp-app/_wp-app-conf.mk-create

_wp-app/_wp-app-conf.mk-create:
	@echo "_wp-app/_wp-app-conf.mk-create"
	printf "$$WP_APP_CONF" > $(WP_APP_PROJECT_PATH)/wp-app.conf

_wp-app/_wp-app-conf.mk-create-cp:
	@echo "_wp-app/_wp-app-conf.mk-create-cp"
	cp -f $(WP_APP_PROJECT_PATH)/wp-app.conf $(VOLUMES_NGINX_CONF)/wp-app.conf
