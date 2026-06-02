# wp-app/_wp-cli-media-regenerate.mk

_wp-app/_wp-cli-media-regenerate.mk:
	make _wp-app/_wp-cli-media-regenerate.mk-regenerate

_wp-app/_wp-cli-media-regenerate.mk-regenerate:
	@echo "_wp-app/_wp-cli-media-regenerate.mk-regenerate"
	docker exec -u root $(WP_APP_NAME_APP_ENV) sh -c "\
		apk add --no-cache php84-gd"
	
	@set -a && . $(WP_APP_PROJECT_PATH)/.env.wp-app && set +a && \
	docker exec -u root $(WP_APP_NAME_APP_ENV) sh -c "\
		if [ -f $$WP_PATH/wp-config.php ]; then \
			wp media regenerate --yes --path=$$WP_PATH --allow-root || true; \
		fi"