# wp-app/_restart-services.mk

_wp-app/_restart-services.mk:
	@echo "_wp-app/_restart-services.mk"
	@echo "Using env: wp-app/.env.wp-app"
	@set -a && . ./wp-app/.env.wp-app && set +a && \
		docker exec -u root $(PHP_FPM_NAME) sh -c "\
		chown -R nobody:nobody /var/www/html/$$WP_PATH; \
		chmod -R 775 /var/www/html/$$WP_PATH"
	docker restart $(NGINX_NAME)
	docker restart $(PHP_FPM_NAME)