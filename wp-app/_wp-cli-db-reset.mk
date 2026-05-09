# wp-app/_wp-cli-db-reset.mk

_wp-app/_wp-cli-db-reset.mk:
	@echo "wp-app/_wp-cli-db-reset.mk"
	@echo "Using env: wp-app/.env.wp-app"
	@set -a && . ./wp-app/.env.wp-app && set +a && \
	docker exec $(WP_APP_NAME) sh -c "wp db reset --path=/$$WP_PATH --yes --allow-root"