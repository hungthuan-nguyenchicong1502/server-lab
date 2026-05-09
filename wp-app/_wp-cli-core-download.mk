# wp-app/_wp-cli-core-download.mk

_wp-app/_wp-cli-core-download.mk:
	@echo "wp-app/_wp-cli-core-download.mk"
	@echo "Using env: wp-app/.env.wp-app"
	@set -a && . ./wp-app/.env.wp-app && set +a && \
	docker exec $(WP_APP_NAME) sh -c "\
		if [ ! -f /$$WP_PATH/wp-settings.php ]; then \
			wp core download --path=/$$WP_PATH --allow-root; \
		fi"