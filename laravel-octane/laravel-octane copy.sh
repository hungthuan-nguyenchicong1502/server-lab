#!/bin/sh
# Sửa compose.json thành composer.json
if [ -f /laravel-app/composer.json ]; then
    cd /laravel-app

    php artisan optimize:clear
    # Cài đặt nếu chưa có
    composer require laravel/octane --quiet
    # Cài đặt các file binary và config của Octane
    php artisan octane:install --server=swoole --force
fi

# Thực thi lệnh CMD từ Dockerfile
exec "$@"