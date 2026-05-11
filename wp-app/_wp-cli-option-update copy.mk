# wp-app/_wp-cli-option-update.mk

_wp-app/_wp-cli-option-update.mk:
	@echo "_wp-app/_wp-cli-option-update.mk"
	@set -a && . $(WP_APP_PROJECT_PATH)/.env.wp-app && set +a && \
	docker exec $(WP_APP_NAME) sh -c "\
		if [ -f /$$WP_PATH/wp-config.php ]; then \
			wp option update siteurl "$$WP_URL" --path=/$$WP_PATH --allow-root || true; \
			wp option update home "$$WP_URL" --path=/$$WP_PATH --allow-root || true; \
			wp option update thumbnail_size_w 400 --autoload=yes --path=/$$WP_PATH --allow-root || true; \
			wp option update thumbnail_size_h 400 --autoload=yes --path=/$$WP_PATH --allow-root || true; \
			wp option update medium_size_w 0 --autoload=no --path=/$$WP_PATH --allow-root || true; \
			wp option update medium_size_h 0 --autoload=no --path=/$$WP_PATH --allow-root || true; \
			wp option update large_size_w 0 --autoload=no --path=/$$WP_PATH --allow-root || true; \
			wp option update large_size_h 0 --autoload=no --path=/$$WP_PATH --allow-root || true; \
			wp option update medium_large_size_w 0 --autoload=no --path=/$$WP_PATH --allow-root || true; \
			wp option update medium_large_size_h 0 --autoload=no --path=/$$WP_PATH --allow-root || true; \
		fi"