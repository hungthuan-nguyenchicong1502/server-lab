# 1. Định nghĩa đoạn code PHP (Dùng $$ để Makefile hiểu là ký tự $)
define WP_APP_PROXY_FIX_CODE
if (isset($$_SERVER['HTTP_X_FORWARDED_PROTO']) && $$_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $$_SERVER['HTTPS'] = 'on';
}
endef

export WP_APP_PROXY_FIX_CODE

_wp-app/_wp-cli-config-create.mk:
	@echo "_wp-app/_wp-cli-config-create.mk"
	@echo "Using env: wp-app/.env.wp-app"
	@set -a && . $(WP_APP_PROJECT_PATH)/.env.wp-app && set +a && \
	docker exec -u root -e PHP_FIX="$$WP_APP_PROXY_FIX_CODE" $(WP_APP_NAME_APP_ENV) sh -c "\
		if [ -f $$WP_PATH/wp-config.php ]; then \
			rm -f $$WP_PATH/wp-config.php; \
		fi; \
		printf '%s\n' \"\$$PHP_FIX\" > /tmp/proxy_fix.php && \
		wp config create --path=$$WP_PATH \
			--dbname=\"$$DB_NAME\" \
			--dbuser=\"$$DB_USER\" \
			--dbpass=\"$$DB_PASSWORD\" \
			--dbhost=\"$$DB_HOST\" \
			--dbcharset=\"$$DB_CHARSET\" \
			--dbcollate=\"$$DB_COLLATE\" \
			--extra-php < /tmp/proxy_fix.php \
			--allow-root && \
		rm /tmp/proxy_fix.php"