#!/bin/sh
cd /laravel-app

# 1. Ép biến môi trường vào Shell hiện tại
export OCTANE_SERVER=swoole

if [ -f /laravel-app/composer.json ]; then
    # 2. Xóa cache cấu hình cũ (Rất quan trọng)
    php artisan config:clear
    
    # 3. Cài đặt lại nếu cần
    php artisan octane:install
    
    # 4. Đảm bảo database đã sẵn sàng (Tránh lỗi 500 do thiếu bảng session/cache)
    php artisan migrate --force
fi

# 5. Thực thi lệnh start với biến môi trường đã nạp
exec "$@"