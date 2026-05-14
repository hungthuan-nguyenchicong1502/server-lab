chown -R www-data:www-data /var/www/html/laravel-app/storage /var/www/html/laravel-app/bootstrap/cache
chmod -R 775 /var/www/html/laravel-app/storage /var/www/html/laravel-app/bootstrap/cache

docker exec php-fpm-alpine-ncc-dev chown -R root:nobody /var/www/html/laravel-app/storage /var/www/html/laravel-app/bootstrap/cache
docker exec php-fpm-alpine-ncc-dev chmod -R 775 /var/www/html/laravel-app/storage /var/www/html/laravel-app/bootstrap/cache

# Truy cập vào container Laravel
docker exec php-fpm-alpine-ncc-dev ln -s /var/www/html/wp-app/wp-content/uploads /var/www/html/laravel-app/public/wp-uploads

# Cập nhật kho ứng dụng (đảm bảo đang dùng kho edge hoặc v3.21+ để có PHP 8.4)
apk update

# Cài đặt PHP 8.4 FPM và các thư viện bắt buộc cho Laravel
apk add php84 \
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
    php84-sodium \
    php84-opcache

# Các công cụ hỗ trợ quản lý và cài đặt
apk add curl git unzip composer

services:
  wp-app:
    # ...
    volumes:
      - shared-uploads:/var/www/html/wp-app/wp-content/uploads

  php-fpm-laravel:
    # ...
    volumes:
      - shared-uploads:/var/www/html/laravel-app/public/uploads/wp # Mount thẳng vào public của Laravel
      
volumes:
  shared-uploads:
    driver: local

docker exec php-fpm-alpine-ncc-dev ln -s /var/www/html/wp-app/wp-content/uploads /var/www/html/laravel-app/public/uploads

docker exec php-fpm-alpine-ncc-dev unlink /var/www/html/laravel-app/public/wp-uploads