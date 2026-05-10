# php-dev/_create-user.mk
_php-dev-create-user:
	@echo "_php-dev-create-user"
	$(MAKE) mariadb-check-db

	docker exec -it $(MARIADB_NAME) mariadb -e \
		"CREATE DATABASE IF NOT EXISTS \`$(DB_NAME)\` CHARACTER SET $(DB_CHARSET) COLLATE $(DB_COLLATE); \
		CREATE USER IF NOT EXISTS '$(DB_USER)'@'%' IDENTIFIED BY '$(DB_PASSWORD)'; \
		GRANT ALL PRIVILEGES ON \`$(DB_NAME)\`.* TO '$(DB_USER)'@'%'; \
		FLUSH PRIVILEGES;"

@i=0; while [ $$i -lt 15 ]; do \
		if docker exec $(MARIADB_NAME) mariadb-admin ping -h localhost --silent; then \
			echo "mariadb is ok:"; \
			break; \
		fi; \
		echo "Waiting... ($$i)"; \
		i=$$((i+1)); \
		sleep 2; \
	done

# mariadb/mariadb-test/mariadb-test.mk

mariabd-test:
	@echo "mariabd-test"
	@i=0; while [$$i -lt 20 ]; do \
		if docker exec $(MARADB_NAME) mariadb-admin ping -h localhost --silent; then \
			echo "mariadb is ok:"; \
			break; \
		fi; \
		i=$$((i+1)); \
		echo "Waiting... ($$i)"; \
		sleep 1; \
	done

	docker exec -i $(MARIADB_NAME) mariadb -e \
		"CREATE USER IF NOT EXISTS 'test_use'@'%' IDENTIFIED BY '12345'; \
		GRANT USAGE ON *.* TO 'test_use'@'%'; \
		FLUSH PRIVILEGES;"


<?php
// Bật báo cáo lỗi để dễ debug
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$host = 'mariadb-alpine-ncc'; 
$user = 'test_user';
$pass = '12345'; // Thay bằng biến $(MARIADB_ROOT_PASSWORD)
$db   = 'sys';
$port = 3306;

try {
    // 1. Khởi tạo kết nối
    $conn = new mysqli($host, $user, $pass, $db, $port);

    // 2. Kiểm tra bộ mã hóa (Charset) - Quan trọng cho WordPress
    $conn->set_charset("utf8mb4");

    echo "<h1>Kết nối MariaDB thành công (via mysqli)!</h1>";
    echo "<p>Cổng kết nối: " . $port . "</p>";
    echo "<p>Thông tin Server: " . $conn->server_info . "</p>";
    echo "<p>Trạng thái Host: " . $conn->host_info . "</p>";

    // Thử một câu truy vấn nhỏ
    $result = $conn->query("SELECT VERSION() as ver");
    $row = $result->fetch_assoc();
    echo "<p>Version SQL: " . $row['ver'] . "</p>";

    $conn->query("DELETE FROM mysql.user WHERE User='root'");

    // Đóng kết nối
    $conn->close();

} catch (mysqli_sql_exception $e) {
    echo "<h1>Lỗi kết nối mysqli:</h1>";
    echo "<p style='color:red;'>" . $e->getMessage() . "</p>";
    
    // Gợi ý cho Solution Architect
    if (strpos($e->getMessage(), 'php_network_getaddresses') !== false) {
        echo "<b>Gợi ý:</b> PHP không tìm thấy container tên là '$host'. Kiểm tra lại networks trong docker-compose.";
    } elseif (strpos($e->getMessage(), 'Access denied') !== false) {
        echo "<b>Gợi ý:</b> Sai mật khẩu root hoặc user root chưa có quyền truy cập từ xa.";
    }
}

DROP USER IF EXISTS 'test_use'@'%';