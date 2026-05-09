_wp-cli/wp-cli-test/_create-db-test.mk:
	@echo "Checking MariaDB..."
# 	@# Sửa lỗi logic vòng lặp (thêm khoảng trống cho dấu [ ])
	@i=0; while [ $$i -lt 15 ]; do \
		if docker exec $(MARIADB_NAME) mariadb-admin ping -h localhost --silent; then \
			echo "MariaDB is ok!"; \
			break; \
		fi; \
		echo "Waiting... ($$i)"; \
		i=$$((i+1)); \
		sleep 1; \
	done

	@echo "Using env: wp-cli/wp-cli-test/.env.wp-cli-test"
# 	@# Nạp env và chạy lệnh trên CÙNG MỘT PHIÊN SHELL (nối bằng && \)
	@set -a && . ./wp-cli/wp-cli-test/.env.wp-cli-test && set +a && \
	docker exec -i $(MARIADB_NAME) mariadb -e \
		"CREATE DATABASE IF NOT EXISTS \`$$DB_NAME\` CHARACTER SET $$DB_CHARSET COLLATE $$DB_COLLATE; \
		CREATE USER IF NOT EXISTS '$$DB_USER'@'%' IDENTIFIED BY '$$DB_PASSWORD'; \
		GRANT ALL PRIVILEGES ON \`$$DB_NAME\`.* TO '$$DB_USER'@'%'; \
		FLUSH PRIVILEGES;"