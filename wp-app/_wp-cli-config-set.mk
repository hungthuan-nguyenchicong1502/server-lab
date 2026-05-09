# wp-app/_wp-cli-config-set.mk

_wp-app/_wp-cli-config-set.mk:
	@echo "_wp-app/_wp-cli-config-set.mk"
	@echo "Using env: wp-app/.env.wp-app"
	@set -a && . ./wp-app/.env.wp-app && set +a && \
	docker exec $(WP_APP_NAME) sh -c "\
		if [ -f /$$WP_PATH/wp-settings.php ]; then \
			wp config set WP_HOME \"$$WP_URL\" --path=/$$WP_PATH --allow-root; \
			wp config set WP_SITEURL \"$$WP_URL\" --path=/$$WP_PATH --allow-root; \
		fi"
