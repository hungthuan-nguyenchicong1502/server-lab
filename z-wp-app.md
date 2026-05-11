fix-permission:
	@echo "Fixing permissions..."
	sudo chown -R $(shell id -u):$(shell id -g) ./volumes/project-app
	docker exec -it php-fpm-alpine-ncc-dev chown -R nobody:nobody /var/www/html
	docker exec -it php-fpm-alpine-ncc-dev chmod -R 775 /var/www/html

Đừng usermod trong Makefile: Hãy đảm bảo trong Dockerfile của đại ca đã có sẵn:
RUN addgroup -g 1000 hostuser && adduser -u 1000 -G hostuser -D hostuser (nếu muốn dùng user 1000).

# Dockerfile cho Production
FROM php:8.4-fpm-alpine
COPY ./volumes/project-app /var/www/html
# Chốt quyền ngay khi build image
RUN chown -R nobody:nobody /var/www/html && chmod -R 755 /var/www/html
USER nobody


_wp-app/_php-fpm-permission.mk:
	@echo "Fixing permissions using SGID strategy..."
	@# 1. Đổi group về 65534 (nobody) - dùng ID cho chắc chắn
	sudo chown -R :65534 $(WP_APP_PROJECT_PATH)/volumes/project-app
	
	@# 2. Bật SGID để file mới tạo tự động mang group 65534
	sudo chmod g+s $(WP_APP_PROJECT_PATH)/volumes/project-app
	
	@# 3. Cấp quyền rwx cho cả User và Group (775)
	sudo chmod -R 775 $(WP_APP_PROJECT_PATH)/volumes/project-app

docker exec wp-app-alpine-ncc wp option update siteurl "https://wp-app.hungthuan.com" --allow-root
docker exec wp-app-alpine-ncc wp option update home "https://wp-app.hungthuan.com" --allow-root

define('WP_HOME', 'https://wp-app.hungthuan.com');
define('WP_SITEURL', 'https://wp-app.hungthuan.com');

// Quan trọng: Nếu bạn dùng Cloudflare hoặc Proxy (SSL Termination)
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}

server {
    listen 8080;
    # ... các cấu hình khác ...

    # Tắt việc tự động thêm port vào Redirect
    port_in_redirect off;

    # Hoặc ép buộc absolute_redirect về off
    absolute_redirect off;
}


proxy_set_header Host $host;
proxy_set_header X-Forwarded-Host $host;
proxy_set_header X-Forwarded-Port $server_port; # Thường là 443


define WP_APP_CONF
server {
    listen $(WP_APP_CONF_LISTEN);
    server_name $(WP_APP_CONF_SERVER_NAME);

    # Fix lỗi tự thêm cổng khi redirect (trailing slash)
    absolute_redirect off; 
    port_in_redirect off;

    root /var/www/html/wp-app;
    index index.html index.php;

    location / {
        try_files $$uri $$uri/ /index.php?$$args;
    }

    location ~ \.php$$ {
        try_files $$uri =404;
        fastcgi_pass $(WP_APP_CONF_FASTCGI_PASS):9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $$document_root$$fastcgi_script_name;
        
        # Bổ sung header để PHP/WordPress nhận biết HTTPS từ Proxy
        fastcgi_param HTTPS on;
    }
}
endef

/* Fix lỗi Redirect kèm Port 8080 khi dùng Proxy/Docker */
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}

// Đây là dòng quan trọng nhất: Ép WP tin rằng nó đang ở port chuẩn 443
$_SERVER['SERVER_PORT'] = 443;

// Fix lỗi Host nếu cần
if (isset($_SERVER['HTTP_X_FORWARDED_HOST'])) {
    $_SERVER['HTTP_HOST'] = $_SERVER['HTTP_X_FORWARDED_HOST'];
}

define('WP_HOME', 'https://wp-app.hungthuan.com');
define('WP_SITEURL', 'https://wp-app.hungthuan.com');