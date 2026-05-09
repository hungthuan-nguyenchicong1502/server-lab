# wp-app/wp-app.mk
WP_APP_NAME = wp-app-alpine-ncc
WP_APP_PROJECT_PATH = $(PROJECT_PATH)/wp-app
WP_APP_VOLUMES_PROJECT_APP = $(VOLUMES_PROJECT_APP)/wp-app

include wp-app/_create-connect-mariadb.mk
include wp-app/_create-docker-compose-yml.mk
include wp-app/_docker-compose.mk
include wp-app/_wp-cli-core-download.mk
include wp-app/_wp-cli-config-create.mk
include wp-app/_wp-cli-config-set.mk
include wp-app/_wp-cli-core-install.mk
include wp-app/_wp-cli-option-update.mk
include wp-app/_create-wp-app.mk
include wp-app/_restart-services.mk
include wp-app/_wp-cli-db-reset.mk

_wp-app-prepare:
	@echo "_wp-app-prepare"
	mkdir -p $(WP_APP_PROJECT_PATH)
	mkdir -p $(WP_APP_VOLUMES_PROJECT_APP)
	cp -f ./wp-app/wp-app.conf $(NGINX_VOLUMES_CONF)

wp-app-setup: _wp-app-prepare
	@echo "wp-app-setup"
	$(MAKE) _wp-app/_create-connect-mariadb.mk
	$(MAKE) _wp-app/_create-docker-compose-yml.mk
	$(MAKE) _wp-app/_docker-compose.mk
	$(MAKE) _wp-app/_create-wp-app.mk

	$(MAKE) wp-app-down
	$(MAKE) _wp-app/_restart-services.mk

wp-app-up:
	@echo "wp-app-up"
	$(MAKE) _wp-app/_docker-compose.mk-up

wp-app-down:
	@echo "wp-app-down"
	$(MAKE) _wp-app/_docker-compose.mk-down

wp-app-remove:
	@echo "wp-app-remove"
	$(MAKE) _wp-app/_wp-cli-db-reset.mk
	$(MAKE) _wp-app/_docker-compose.mk-down-v
# 	rm -rf $(WP_APP_VOLUMES_PROJECT_APP)
# Dùng một container tạm thời để xóa folder với quyền root
	docker run --rm -v /home/cong/git/ncc-lab-project/volumes/project-app:/parent $(ALPINE_IMAGE) sh -c "rm -rf /parent/wp-app"
