# wp-app/_wp-cli-core-install.mk

_wp-app/_wp-cli-core-install.mk:
	@echo "wp-app/_wp-cli-core-install.mk"
	@echo "Using env: wp-app/.env.wp-app"
	@set -a && . ./wp-app/.env.wp-app && set +a && \
	docker exec $(WP_APP_NAME) sh -c "\
		if ! wp core is-installed --path=/$$WP_PATH --allow-root; then \
			wp core install --path=/$$WP_PATH \
				--url=\"$$WP_URL\" \
				--title=\"$$WP_TITLE\" \
				--admin_user=\"$$WP_ADMIN\" \
				--admin_password=\"$$WP_ADMIN_PASSWORD\" \
				--admin_email=\"$$WP_ADMIN_EMAIL\" \
				--skip-email \
				--allow-root; \
		fi"
