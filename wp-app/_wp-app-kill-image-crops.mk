# wp-app/_wp-app-kill-image-crops.mk

_wp-app/_wp-app-kill-image-crops.mk:
	@echo "wp-app/_wp-app-kill-image-crops.mk"
	make _wp-app/_wp-app-kill-image-crops.mk-create

_wp-app/_wp-app-kill-image-crops.mk-create:
	docker exec -i $(WP_APP_NAME_APP_ENV) sh -c "mkdir -p /var/www/html/wp-app/wp-content/mu-plugins"
	docker cp ./wp-app/kill-image-crops.php $(WP_APP_NAME_APP_ENV):/var/www/html/wp-app/wp-content/mu-plugins