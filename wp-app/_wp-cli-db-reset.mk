# wp-app/_wp-cli-db-reset.mk

_wp-app/_wp-cli-db-reset.mk:
	@echo "wp-app/_wp-cli-db-reset.mk"
	@echo "Using env: wp-app/.env.wp-app"
	@set -a && . $(WP_APP_PROJECT_PATH)/.env.wp-app && set +a && \
	docker exec -u root $(WP_APP_NAME_APP_ENV) sh -c "wp db reset --path=$$WP_PATH --yes --allow-root"