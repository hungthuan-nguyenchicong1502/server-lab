# mariadb/mariadb-test/mariadb-test.mk

_mariabd-test:
	@echo "mariabd-test"
	@i=0; while [ $$i -lt 20 ]; do \
		if docker exec $(MARADB_NAME) mariadb-admin ping -h localhost --silent; then \
			echo "mariadb is ok:"; \
			break; \
		fi; \
		i=$$((i+1)); \
		echo "Waiting... ($$i)"; \
		sleep 1; \
	done

	docker exec -i $(MARIADB_NAME) mariadb -e \
		"CREATE USER IF NOT EXISTS 'test_user'@'%' IDENTIFIED BY '12345'; \
		GRANT USAGE ON *.* TO 'test_user'@'%'; \
		FLUSH PRIVILEGES;"