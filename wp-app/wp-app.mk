# wp-app/wp-app.mk
WP_APP_NAME := wp-app-alpine-ncc
WP_APP_PROJECT_PATH := $(PROJECT_PATH)/wp-app
WP_APP_VERSION := v.1.0.0
# Dockerfile
# docker-compose.yml
WP_APP_IMAGE = $(WP_APP_NAME)-$(WP_APP_VERSION)
WP_APP_NAME_APP_ENV := $(WP_APP_NAME)
WP_APP_DOCKERFILE := Dockerfile.$(APP_ENV)

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
	sleep 1

wp-app-create-wp-app:
	@echo "wp-app-create-wp-app"
	make wp-app-up
	sleep 1

	make _wp-app/_wp-app-init.mk
	sleep 1
	make _wp-app/_wp-app-create-wp-app.mk
	sleep 1
	make wp-app-down
	sleep 1
	make _wp-app/_php-fpm-permission.mk

wp-app-up:
	@echo "wp-app-up"
	$(MAKE) _wp-app/_docker-compose.mk-up

wp-app-down:
	@echo "wp-app-down"
	$(MAKE) _wp-app/_docker-compose.mk-down

wp-app-rm-wp-app:
	@echo "wp-app-rm-wp-app"
	make _wp-app/_wp-cli-db-reset.mk
	make _wp-app/_docker-compose.mk-down-v
# 	rm -rf $(WP_APP_VOLUMES_PROJECT_APP)
# Dùng một container tạm thời để xóa folder với quyền root
	docker run --rm -v $(VOLUMES_WP_APP):/parent $(ALPINE_IMAGE) sh -c "\
		chown -R root:root /parent; \
		chmod -R 777 /parent; \
		rm -rf /parent/wp-app"
	make wp-app-conf-remove

wp-app-conf-remove:
	@echo "wp-app-config-remove"
	rm -f $(NGINX_VOLUMES_CONF)/wp-app.conf
	sleep 1
	make nginx-reload
