# wp-app/_wp-app-env.mk
# WP_APP_ENV

_wp-app/_wp-app-env.mk:
	@echo "wp-app/_wp-app-env.mk"
	make "_wp-app/_wp-app-env.mk-create"

_wp-app/_wp-app-env.mk-create:
	@echo "_wp-app/_wp-app-env.mk-create"
	printf "$$WP_APP_ENV" > $(WP_APP_PROJECT_PATH)/.env.wp-app