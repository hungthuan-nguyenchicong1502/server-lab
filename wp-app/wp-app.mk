# wp-app/wp-app.mk
WP_APP_NAME := wp-app-alpine-ncc
WP_APP_PROJECT_PATH := $(PROJECT_PATH)/wp-app
WP_APP_VERSION := v.1.0.0
# Dockerfile
# docker-compose.yml
WP_APP_IMAGE = $(WP_APP_NAME)-$(WP_APP_VERSION)
WP_APP_NAME_APP_ENV := $(WP_APP_NAME)
WP_APP_WORKDIR := $(WP_PATH)

include wp-app/_define-docker-file.mk
include wp-app/_docker-file.mk
include wp-app/_define-docker-compose-yml.mk
include wp-app/_docker-compose.mk

include wp-app/_wp-app-init.mk

include wp-app/_wp-app-create-wp-app.mk

include wp-app/_php-fpm-permission.mk

_wp-app-prepare: _prepare
	@echo "_wp-app-prepare"
	mkdir -p $(WP_APP_PROJECT_PATH)

wp-app-setup: _wp-app-prepare
	@echo "wp-app-setup"
	make _wp-app/_docker-file.mk
	make _wp-app/_docker-compose.mk

wp-app-build:
	@echo "wp-app-build"
	make _wp-app-docker-build

wp-app-create-wp-app:
	@echo "wp-app-create-wp-app"
	make wp-app-up
	make _wp-app/_wp-app-init.mk
	make _wp-app/_wp-app-create-wp-app.mk
	make wp-app-down
	make _wp-app/_php-fpm-permission.mk

wp-app-up:
	@echo "wp-app-up"
	$(MAKE) _wp-app/_docker-compose.mk-up

wp-app-down:
	@echo "wp-app-down"
	$(MAKE) _wp-app/_docker-compose.mk-down

wp-app-option-update-woocommerce:
	@echo "wp-app-option-update-woocommerce"
	make wp-app-setup
	make wp-app-up
	make _wp-app/_wp-cli-option-update.mk-woocommerce
	sleep 1
	make wp-app-down

wp-app-option-update:
	@echo "wp-app-option-update"
	make wp-app-up
	make _wp-app/_wp-cli-option-update.mk
	make _wp-app/_wp-cli-option-update.mk-woocommerce
	sleep 1
	make wp-app-down

wp-app-db-reset:
	@echo "wp-app-db-reset"
	make wp-app-up
	sleep 1
	make _wp-app/_wp-cli-db-reset.mk
	sleep 1
	make wp-app-down


wp-app-rm-wp-app:
	@echo "wp-app-rm-wp-app"
	docker run -u root --rm -v $(VOLUMES_WP_APP):/parent $(ALPINE_IMAGE) sh -c "\
		chown -R root:root /parent; \
		chmod -R 777 /parent; \
		rm -rf /parent/wp-app"
	rm -rf $(VOLUMES_WP_APP)

wp-app-conf-remove:
	@echo "wp-app-config-remove"
	rm -f $(NGINX_VOLUMES_CONF)/wp-app.conf
	sleep 1
	make nginx-reload
