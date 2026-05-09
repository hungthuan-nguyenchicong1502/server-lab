# wp-cli/_install.mk

_wp-cli-install:
	@echo "_wp-cli-install"
	$(MAKE) _wp-cli-create-use-db

_wp-cli-create-use-db:
	@echo "_wp-cli-create-use-db"
	@echo "check mariadb..."

	@i=0; while [ $$i -lt 15 ]; do \
		if docker exec $(MARIADB_NAME) mariadb-admin ping -h localhost --silent; then \
			echo "mariadb is ok:"; \
			break; \
		fi; \
		echo "Waiting... ($$i)"; \
		i=$$((i+1)); \
		sleep 2; \
	done

	docker exec -i $(MARIADB_NAME) mariadb -e \
		"CREATE DATABASE IF NOT EXISTS \`$(DB_NAME)\` CHARACTER SET $(DB_CHARSET) COLLATE $(DB_COLLATE); \
		CREATE USER IF NOT EXISTS '$(DB_USER)'@'%' IDENTIFIED BY '$(DB_PASSWORD)'; \
		GRANT ALL PRIVILEGES ON \`$(DB_NAME)\`.* TO '$(DB_USER)'@'%'; \
		FLUSH PRIVILEGES;"

# Không include gì ở đầu file cả

_create-db-%:
	@# Lấy tên module từ dấu % (ví dụ: wp-cli-test)
	$(eval MODULE_NAME=$*)
	$(eval ENV_FILE=wp-cli/$(MODULE_NAME)/.env.$(MODULE_NAME))
	
	@echo "Loading $(ENV_FILE)..."
	@# Chạy lệnh thực thi và nạp env trực tiếp bằng shell thay vì dùng include của Make
	@set -a && . ./$(ENV_FILE) && set +a && \
	docker exec -i $$MARIADB_NAME mariadb -e \
		"CREATE DATABASE IF NOT EXISTS \`$$DB_NAME\`..."

# Target tạo DB cho bất kỳ module nào
_create-db-%:
	@$(eval ENV_FILE=wp-cli/$*/.env.$*)
	@echo "--- Creating DB for Module: $* ---"
	@set -a && . ./$(ENV_FILE) && set +a && \
	docker exec -i $$MARIADB_NAME mariadb -e "CREATE DATABASE IF NOT EXISTS \`$$DB_NAME\`..."

# Target chạy WP-CLI cho bất kỳ module nào
_install-wp-%:
	@$(eval ENV_FILE=wp-cli/$*/.env.$*)
	@echo "--- Installing WP for Module: $* ---"
	@set -a && . ./$(ENV_FILE) && set +a && \
	docker exec -i $$CONTAINER_NAME wp core install --url=$$SITE_URL --title=$$TITLE ...

# Setup toàn bộ cho module test
setup-test: _create-db-wp-cli-test _install-wp-wp-cli-test
	@echo "Setup test hoàn tất!"

# Setup cho một module khác (ví dụ erp-test)
setup-erp: _create-db-erp-test _install-wp-erp-test
	@echo "Setup ERP hoàn tất!"

# run
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

## run v2
xu ly wp core download --path=wp-app --force --allow-root

wp config create --path=/app/wp-app
--dbname="DB_NAME"
--dbuser="DB_USER"
--dbpass="DB_PASS"
--dbhost="DB_HOST"
--dbcharset="DB_CHARSET"
--dbcollate="DB_COLLATE"
--skip-check

_wp-cli/wp-cli-test/_create-wp-cli-app-test.mk:
	@echo "Running: _wp-cli/wp-cli-test/_create-wp-cli-app-test.mk"
	@set -a && . ./wp-cli/wp-cli-test/.env.wp-cli-test && set +a && \
	echo "Using path: /$$WP_PATH" && \
	docker exec $(WP_CLI_NAME) wp core download --path=/$$WP_PATH --force --allow-root && \
	docker exec $(WP_CLI_NAME) sh -c "\
		wp config create --path=/$$WP_PATH \
		--dbname=\"$$DB_NAME\" \
		--dbuser=\"$$DB_USER\" \
		--dbpass=\"$$DB_PASSWORD\" \
		--dbhost=\"$$DB_HOST\" \
		--dbcharset=\"$$DB_CHARSET\" \
		--dbcollate=\"$$DB_COLLATE\" \
		--allow-root"

_update-config:
	@set -a && . ./$(ENV_FILE) && set +a && \
	if docker exec $(WP_CLI_NAME) [ ! -f /$$WP_PATH/wp-config.php ]; then \
		echo "Config chưa có, đang tạo mới..."; \
		docker exec $(WP_CLI_NAME) wp config create ... ; \
	else \
		echo "Config đã tồn tại, đang cập nhật thông số..."; \
		docker exec $(WP_CLI_NAME) wp config set DB_HOST "$$DB_HOST" --path=/$$WP_PATH --allow-root; \
	fi

## xu ly wp core install

wp core is-installed --path=wp-app ||
wp core install --path=wp-app
--url=$(WP_URL)
--title="$(WP_TITLE)"
--admin_user=$(WP_ADMIN)
--admin_password=$(WP_ADMIN_PASSWORD)
--admin_email=$(WP_ADMIN_EMAIL)
--skip-email"

## run dev

services:
  wp-cli:
    # ... các cấu hình cũ ...
    ports:
      - "8080:8080"

docker exec -it wp-cli-alpine-ncc sh -c "cd /wp-cli-test && wp server --host=0.0.0.0 --port=8080 --allow-root"
    ```
    *Lưu ý: Phải dùng `--host=0.0.0.0` thì máy thật của bạn mới kết nối vào được.*

---

### 2. Cách "Professional": Dùng Service Web (Nginx/Apache)
Trong một kiến trúc Solution Architect, bạn nên có một container riêng cho PHP-FPM và Nginx. 

*   **VS Code:** Bạn dùng Extension **"Remote - Containers"** hoặc **"Dev Containers"**.
*   **Kết nối:** VS Code sẽ "nhảy" thẳng vào trong container `wp-cli-alpine-ncc`. Bạn chỉ cần mở folder `/wp-cli-test` trong VS Code là có thể code trực tiếp.

---

### 3. Để VS Code "bắt" được (Debugging với Xdebug)
Để VS Code có thể debug (đặt breakpoint), việc chạy `wp server` là chưa đủ. Bạn cần cài **Xdebug** vào container Alpine đó.

**Các bước cần làm:**
1.  **Cài Xdebug:** `apk add php-xdebug`.
2.  **Cấu hình `xdebug.ini`:** 
    
```ini
    xdebug.mode=debug
    xdebug.start_with_request=yes
    xdebug.client_host=host.docker.internal # Để nó gọi ngược về VS Code
    xdebug.client_port=9003
    ```
3.  **VS Code:** Cài extension "PHP Debug" và tạo file `launch.json`.

---

### 4. Câu hỏi cho bước tiếp theo của bạn
Bạn muốn đi theo hướng nào?
1.  **Hướng đơn giản:** Chỉ cần chạy lệnh để hiện giao diện web lên port 8080 để test nhanh.
2.  **Hướng chuyên sâu:** Cấu hình để VS Code có thể Remote Development (Sửa code trong Container và tự động cập nhật ra trình duyệt).

Nếu bạn chọn hướng **Remote Development**, tôi sẽ hướng dẫn bạn cách mapping để khi bạn sửa file trong `~/git/server-lab/wp-app` trên máy thật, nó sẽ tác động ngay lập tức vào `/wp-cli-test` trong container mà không cần download lại.