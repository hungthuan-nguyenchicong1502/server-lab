# wp-app/wp-app.mk
WP_APP_NAME = wp-app-alpine-ncc
WP_APP_PROJECT_PATH = $(PROJECT_PATH)/wp-app
WP_APP_VOLUMES_PROJECT_APP = $(VOLUMES_PROJECT_APP)/wp-app

include wp-app/_wp-app-init.mk

include wp-app/_define-docker-compose-yml.mk
include wp-app/_docker-compose.mk

include wp-app/_wp-cli-z-create-wp-app.mk

include wp-app/_php-fpm-permission.mk

# test:
# 	cat $(WP_APP_VOLUMES_PROJECT_APP)/wp-config.php
# 	docker logs $(MARIADB_NAME)
# 	docker exec -it mariadb-alpine-ncc mariadb -u wp_app_user -pcong12345 wp_app_database -e "status"
# 	docker exec $(WP_APP_NAME) wp db reset --yes --path=/wp-app --allow-root
# 	cat $(WP_APP_PROJECT_PATH)/wp-app.conf
# 	ls $(WP_APP_VOLUMES_PROJECT_APP)/wp-content/uploads/2026/05

_wp-app-prepare:
	@echo "_wp-app-prepare"
	mkdir -p $(WP_APP_PROJECT_PATH)
	mkdir -p $(WP_APP_VOLUMES_PROJECT_APP)
	$(MAKE) _wp-app/_wp-app-init.mk

wp-app-setup: _wp-app-prepare
	@echo "wp-app-setup"
	$(MAKE) _wp-app/_docker-compose.mk
	sleep 2;
	$(MAKE) _wp-app/_wp-cli-z-create-wp-app.mk

	$(MAKE) wp-app-down
# 	$(MAKE) _wp-app/_restart-services.mk
	$(MAKE) php-fpm-restart
	$(MAKE) nginx-restart
	
	$(MAKE) _wp-app/_php-fpm-permission.mk

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

wp-app-conf-remove:
	@echo "wp-app-config-remove"
	rm -f $(NGINX_VOLUMES_CONF)/wp-app.conf
