```
FROM php:8.2-cli-alpine

# Cài đặt các thư viện hệ thống cần thiết và Swoole
RUN apk add --no-cache libstdc++ bzip2-dev \
    libpng-dev libjpeg-turbo-dev freetype-dev \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install swoole \
    && docker-php-ext-enable swoole \
    && apk del .build-deps

# Khai báo thư mục làm việc
WORKDIR /var/www/html

# Port mặc định của Octane Swoole
EXPOSE 8000

# Lệnh khởi chạy Octane (Sẽ chạy mỗi khi container start)
CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=8000"]
```

composer require laravel/octane

    composer require laravel/octane --quiet

    php artisan octane:install --server=swoole --force
## fix

RUN apk add --no-cache php84-pecl-swoole php84-pcntl php84-posix php84-tokenizer php84-session

apk add --no-cache php84-pecl-swoole php84-pcntl php84-posix php84-tokenizer php84-session
## note php
```
FROM alpine:3.20

# Cài đặt PHP 8.4 và các extension cần thiết cho Laravel Octane bằng apk
RUN apk add --no-cache \
    php84 \
    php84-cli \
    php84-pecl-swoole \
    php84-pcntl \
    php84-posix \
    php84-tokenizer \
    php84-session \
    php84-curl \
    php84-openssl \
    php84-mbstring \
    php84-xml

# Tạo một liên kết (alias) để khi gõ "php" hệ thống tự hiểu là "php84"
RUN ln -sf /usr/bin/php84 /usr/bin/php

WORKDIR /home/project/laravel-app

EXPOSE 8000

# Chạy Laravel Octane bằng lệnh php84
CMD ["php84", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=8000"]
```

RUN composer create-project laravel/laravel:^12 laravel-app

composer create-project laravel/laravel:^12 laravel-app

cd laravel-app

composer require laravel/octane

php artisan octane:start --server=swoole --host=0.0.0.0 --port=8000

## fix update init

```
# Lệnh này chạy dưới máy host trước khi up container
init-project:
	@if [ ! -f source/composer.json ]; then \
		echo "Thư mục source trống! Đang khởi tạo Laravel..."; \
		docker run --rm -v $(PWD)/source:/var/www/html -w /var/www/html composer create-project laravel/laravel .; \
	fi
	@if ! grep -q "laravel/octane" source/composer.json; then \
		echo "Chưa có Octane! Đang cài đặt laravel/octane..."; \
		docker run --rm -v $(PWD)/source:/var/www/html -w /var/www/html composer require laravel/octane --quiet; \
	fi

up: init-project
	docker compose up -d
```