RUN apk update && apk upgrade --no-cache && \
	apk add --no-cache \
		mariadb mariadb-client
EXPOSE 3306

COPY ./mariadb.sh /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mariadbd", "--user=mysql", "--console", "--bind-address=0.0.0.0", "--skip-networking=0"]

volumes:
   - $(MARIADB_PROJECT_PATH)/mariadb-data:/var/lib/mysql

mkdir -p /run/mysqld /var/lib/mysql

chown -R mysql:mysql /run/mysqld /var/lib/mysql
chmod -R 755 /run/mysqld /var/lib/mysql

# tao db

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    # mariadb-secure-installation
fi

exec "$@"

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

# Sau khi khởi động MariaDB tạm thời thành công
mariadb -u root <<EOF
-- Thiết lập mật khẩu root
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password123';
-- Xóa các user ẩn danh
DELETE FROM mysql.user WHERE User='';
-- Xóa database test
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
-- Cập nhật lại quyền
FLUSH PRIVILEGES;
EOF

# docker exec mariadb-alpine-ncc mariadb-admin ping -h localhost --silent

docker exec mariadb-alpine-ncc ps aux

docker exec mariadb-alpine-ncc netstat -tulpn
-t (TCP): Chỉ hiển thị các kết nối sử dụng giao thức TCP (Transmission Control)
-u (UDP): Chỉ hiển thị các kết nối sử dụng giao thức UDP (User Datagram Protocol).
-l (Listening): Chỉ hiển thị các cổng đang ở trạng thái đang lắng nghe (Listening)
-p (Programs): Hiển thị thêm cột PID (ID tiến trình)

#!/bin/sh
set -e

mkdir -p /run/mysqld /var/lib/mysql

chown -R mysql:mysql /run/mysqld /var/lib/mysql
chmod -R 755 /run/mysqld /var/lib/mysql

# tao db

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
    # mariadb-secure-installation
fi

# mariadb-secure-installation
# Chờ MariaDB sẵn sàng
i=0
while [ $i -lt 20 ]; do
    if mariadb-admin ping -h localhost --silent; then
        echo "MariaDB is up and running!"
        break
    fi
    echo "Waiting for MariaDB... ($i)"
    sleep 2
    i=$((i + 1))
done

# Các câu trả lời lần lượt: 
# 1. Mật khẩu hiện tại (trống) -> \n
# 2. Switch to unix_socket? (n) -> n\n
# 3. Change root password? (y) -> y\n
# 4. Mật khẩu mới -> password123\n
# 5. Nhập lại mật khẩu -> password123\n
# 6. Remove anonymous users? (y) -> y\n
# 7. Disallow root login remotely? (y) -> y\n
# 8. Remove test database? (y) -> y\n
# 9. Reload privilege tables? (y) -> y\n

# printf "\nn\ny\npassword123\npassword123\ny\ny\ny\ny\n" | mariadb-secure-installation
printf "\nn\nn\n\ny\ny\ny\ny\n" | mariadb-secure-installation

exec "$@"