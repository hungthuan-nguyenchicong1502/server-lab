# z-laravel-fpm-fix
php-fpm-down

php-fpm-up

docker exec -it php-fpm-alpine-ncc-dev sh

CMD ["php-fpm84", "-F"]

php-fpm84 -D -R

netstat -tulpn | grep :9000

kill -USR2 1

apk add --no-cache \
    php84-fpm \
    php84-ctype \
    php84-curl \
    php84-dom \
    php84-fileinfo \
    php84-gd \
    php84-gettext \
    php84-iconv \
    php84-intl \
    php84-mbstring \
    php84-openssl \
    php84-pdo \
    php84-pdo_mysql \
    php84-pdo_sqlite \
    php84-phar \
    php84-session \
    php84-tokenizer \
    php84-xml \
    php84-xmlreader \
    php84-xmlwriter \
    php84-zip \
    php84-zlib \
    php84-bcmath \
    php84-sodium

chown -R root:nobody /var/www/html/wp-app/wp-content && \
chmod -R 775 /var/www/html/wp-app/wp-content

docker exec php-fpm-alpine-ncc-dev sh - c "chown -R root:nobody /var/www/html/wp-app/wp-content && \
chmod -R 775 /var/www/html/wp-app/wp-content"

docker exec php-fpm-alpine-ncc-dev chown -R root:nobody /var/www/html/wp-app/wp-content
docker exec php-fpm-alpine-ncc-dev chmod -R 775 /var/www/html/wp-app/wp-content

docker exec php-fpm-alpine-ncc-dev apk add --no-cache php84

docker restart php-fpm-alpine-ncc-dev

ps aux | grep php-fpm

chown -R root:nobody /var/www/html/wp-app

chmod -R 775 /var/www/html/wp-app

chown -R nobody:nobody /var/www/html/wp-app/wp-content/plugins

chmod -R 775 /var/www/html/wp-app/wp-content/plugins