# wp-app/_wp-cli-core-download.mk

_wp-app/_wp-cli-core-download.mk:
	@echo "wp-app/_wp-cli-core-download.mk"
	@echo "Using env: wp-app/.env.wp-app"
	@set -a && . $(WP_APP_PROJECT_PATH)/.env.wp-app && set +a && \
	docker exec -u root $(WP_APP_NAME_APP_ENV) sh -c "\
		if [ ! -f $$WP_PATH/wp-settings.php ]; then \
			WP_CLI_PHP_ARGS=\"-d memory_limit=512M\" /usr/bin/wp core download --path=$$WP_PATH --allow-root; \
		fi"