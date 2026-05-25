#!/bin/sh
# Sửa compose.json thành composer.json
if [ -f /home/project/laravel-app/composer.json ]; then
    cd /home/project/laravel-app

    php artisan optimize:clear
    # Cài đặt nếu chưa có
    composer require laravel/octane --quiet
    # Cài đặt các file binary và config của Octane
    php artisan octane:install --server=swoole --force
fi

# Thực thi lệnh CMD từ Dockerfile
exec "$@"