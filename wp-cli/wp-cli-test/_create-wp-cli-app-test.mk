# wp-cli/wp-cli-test/_create-wp-cli-app-test.mk

_wp-cli/wp-cli-test/_create-wp-cli-app-test.mk:
	@echo "_wp-cli/wp-cli-test/_create-wp-cli-app-test.mk"
# 	xu ly wp core download --path=wp-app
	@set -a && . ./wp-cli/wp-cli-test/.env.wp-cli-test && set +a && \
	docker exec $(WP_CLI_NAME) wp core download --path=/$$WP_PATH --allow-root --force && \
	docker exec $(WP_CLI_NAME) sh -c "\
		wp config create --path=/$$WP_PATH \
		--dbname=\"$$DB_NAME\" \
		--dbuser=\"$$DB_USER\" \
		--dbpass=\"$$DB_PASSWORD\" \
		--dbhost=\"$$DB_HOST\" \
		--dbcharset=\"$$DB_CHARSET\" \
		--dbcollate=\"$$DB_COLLATE\" \
		--allow-root \
		--force" && \
	docker exec $(WP_CLI_NAME) sh -c "\
		wp db reset --path=/$$WP_PATH --yes --allow-root && \
		wp core install --path=/$$WP_PATH \
		--url=\"$$WP_URL\" \
		--title=\"$$WP_TITLE\" \
		--admin_user=\"$$WP_ADMIN\" \
		--admin_password=\"$$WP_ADMIN_PASSWORD\" \
		--admin_email=\"$$WP_ADMIN_EMAIL\" \
		--skip-email \
		--allow-root"
