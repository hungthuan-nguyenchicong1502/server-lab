# wp-app/_create-connect-mariadb.mk

_wp-app/_create-connect-mariadb.mk:
	@echo "_wp-app/_create-connect-mariadb.mk"
	@echo "Checking MariaDB..."
	@i=0; while [ $$i -lt 15 ]; do \
		if docker exec $(MARIADB_NAME) mariadb-admin ping -h localhost --silent; then \
			echo "MariaDB is ok!"; \
			break; \
		fi; \
		echo "Waiting... ($$i)"; \
		i=$$((i+1)); \
		sleep 1; \
	done
	@echo "Using env: wp-app/.env.wp-app"
	@set -a && . $(WP_APP_PROJECT_PATH)/.env.wp-app set +a && \
	docker exec -i $(MARIADB_NAME) mariadb -e \
		"CREATE DATABASE IF NOT EXISTS \`$$DB_NAME\` CHARACTER SET $$DB_CHARSET COLLATE $$DB_COLLATE; \
		CREATE USER IF NOT EXISTS '$$DB_USER'@'%' IDENTIFIED BY '$$DB_PASSWORD'; \
		GRANT ALL PRIVILEGES ON \`$$DB_NAME\`.* TO '$$DB_USER'@'%'; \
		FLUSH PRIVILEGES;"
