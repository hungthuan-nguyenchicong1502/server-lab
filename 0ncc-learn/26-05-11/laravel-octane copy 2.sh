#!/bin/sh
if [ -f /laravel-app/composer.json ]; then
    cd /laravel-app
    
    # Đảm bảo file .env tồn tại để Octane đọc cấu hình
    if [ ! -f .env ]; then
        cp .env.example .env
    fi

    # Cài đặt nếu chưa có
    composer require laravel/octane --quiet
    
    # ÉP BUỘC biến môi trường trước khi cài đặt/chạy
    export OCTANE_SERVER=swoole
    
    php artisan octane:install --server=swoole --force
fi

# Thực thi lệnh CMD
exec "$@"