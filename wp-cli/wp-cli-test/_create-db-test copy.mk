# wp-cli/wp-cli-test/_create-db-test.mk

# include wp-cli/wp-cli-test/.env.wp-cli-test

_wp-cli/wp-cli-test/_create-db-test.mk:
	@echo "_wp-cli/wp-cli-test/_create-db-test.mk"
	@echo "check mariadb"
	@i=0 while [ $$i - lt 15 ]; do \
		if docker exec $(MARIADB_NAME) mariadb-admin ping -h localhost --silent; then \
			echo "mariadb is ok:"; \
			break; \
		fi; \
		echo "Waiting... ($$i)"; \
		i=$$((i+1)); \
		sleep 1; \
	done

	@echo "use wp-cli/wp-cli-test/.env.wp-cli-test"
	$(eval ENV_FILE=wp-cli/wp-cli-test/.env.wp-cli-test)
	set -a && . ./$(ENV_FILE) && set +a && \
	docker exec -i $(MARIADB_NAME) mariadb -e \
		"CREATE DATABASE IF NOT EXISTS  \`$$DB_NAME\` CHARACTER SET $$DB_CHARSET COLLATE $$DB_COLLATE; \
		CREATE USER IF NOT EXISTS '$$DB_USER'@'%' IDENTIFIED BY '$$DB_PASSWORD';
		GRANT ALL PRIVILEGES ON \`$$DB_NAME\`.* TO '$$DB_USER'@'%'; \
		FLUSH PRIVILEGES;"