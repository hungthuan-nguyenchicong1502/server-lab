# wp-app/_wp-cli-option-update.mk

_wp-app/_wp-cli-option-update.mk:
	@echo "_wp-app/_wp-cli-option-update.mk"
	@set -a && . $(WP_APP_PROJECT_PATH)/.env.wp-app && set +a && \
	docker exec -u root $(WP_APP_NAME_APP_ENV) sh -c "\
		if [ -f $$WP_PATH/wp-config.php ]; then \
			wp option update thumbnail_size_w 300 --autoload=yes --path=$$WP_PATH --allow-root || true; \
			wp option update thumbnail_size_h 300 --autoload=yes --path=$$WP_PATH --allow-root || true; \
			wp option update medium_size_w 0 --autoload=no --path=$$WP_PATH --allow-root || true; \
			wp option update medium_size_h 0 --autoload=no --path=$$WP_PATH --allow-root || true; \
			wp option update large_size_w 0 --autoload=no --path=$$WP_PATH --allow-root || true; \
			wp option update large_size_h 0 --autoload=no --path=$$WP_PATH --allow-root || true; \
			wp option update medium_large_size_w 0 --autoload=no --path=$$WP_PATH --allow-root || true; \
			wp option update medium_large_size_h 0 --autoload=no --path=$$WP_PATH --allow-root || true; \
		fi"

_wp-app/_wp-cli-option-update.mk-woocommerce:
	@echo "_wp-app/_wp-cli-option-update.mk-woocommerce"
	@set -a && . $(WP_APP_PROJECT_PATH)/.env.wp-app && set +a && \
	docker exec -u root $(WP_APP_NAME_APP_ENV) sh -c "\
		if [ -f $$WP_PATH/wp-config.php ]; then \
			wp option update woocommerce_single_image_width 0 --autoload=no --path=$$WP_PATH --allow-root || true; \
			wp option update woocommerce_thumbnail_image_width 0 --autoload=no --path=$$WP_PATH --allow-root || true; \
		fi"