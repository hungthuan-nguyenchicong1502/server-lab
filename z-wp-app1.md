server {
    listen 80;
    root /var/www/html;
    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        # 'php' ở đây là tên service trong docker-compose
        fastcgi_pass php:9000; 
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
}

wp-app-debug:
	docker exec $(MARIADB_NAME) mariadb -u$(DB_USER) -p$(DB_PASSWORD) $(DB_NAME) \
  -e "SELECT option_name, option_value FROM wp_options WHERE option_name IN ('siteurl', 'home');"

  USE wp_app_database;
  SHOW TABLES;

SELECT option_name, option_value 
FROM wp_options 
WHERE option_name IN ('siteurl', 'home');

## .conf

server {
    listen 80;
    server_name _;

    root /var/www/html/php-fpm-test;
    index index.html index.php;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        try_files $uri =404;

        fastcgi_pass php-fpm-alpine-ncc:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}

## fix

// If WordPress is behind a proxy and that proxy sent an 'https' header, 
// force WordPress to recognize the connection as secure.
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}

define('WP_HOME', 'https://hungthuan.com');
define('WP_SITEURL', 'https://hungthuan.com');

_wp-app/_wp-patch-proxy.mk:
	@echo "Patching wp-config.php for Proxy/Cloudflare..."
	@docker exec $(WP_CLI_NAME) sh -c "\
		wp config set WP_HOME 'https://hungthuan.com' --allow-root && \
		wp config set WP_SITEURL 'https://hungthuan.com' --allow-root && \
		wp config set --raw --position=beginning 'if (isset(\$$_SERVER[\"HTTP_X_FORWARDED_PROTO\"]) && \$$_SERVER[\"HTTP_X_FORWARDED_PROTO\"] === \"https\") { \$$_SERVER[\"HTTPS\"] = \"on\"; }' --allow-root"