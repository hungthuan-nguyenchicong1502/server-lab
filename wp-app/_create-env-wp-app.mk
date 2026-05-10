# wp-app/_create-env-wp-app.mk

define WP_APP_ENV
# db wp app
WP_PATH=$(WP_PATH)
DB_HOST=$(DB_HOST)
DB_USER=$(DB_USER)
DB_PASSWORD=$(DB_PASSWORD)
DB_NAME=$(DB_NAME)
DB_CHARSET=$(DB_CHARSET)
DB_COLLATE=$(DB_COLLATE)
# site url
WP_URL=$(WP_URL)
WP_TITLE=$(WP_TITLE)
WP_ADMIN=$(WP_ADMIN)
WP_ADMIN_PASSWORD=$(WP_ADMIN_PASSWORD)
WP_ADMIN_EMAIL=$(WP_ADMIN_EMAIL)
endef

export WP_APP_ENV

_wp-app/_create-env-wp-app.mk:
	@echo "_wp-app/_create-env-wp-app.mk"
	@echo "create ./wp-app/.env.wp-app"
	printf "$$WP_APP_ENV" > ./wp-app/.env.wp-app
