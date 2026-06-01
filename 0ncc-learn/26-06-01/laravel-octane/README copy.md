make laravel-octane-sh

# .env
vi .env

```
APP_ENV=prod

APP_DEBUG=false

DB_CONNECTION=mariadb            
# DB_HOST=          
# DB_PORT=3306                  
# DB_DATABASE=         
# DB_USERNAME=         
# DB_PASSWORD= 

REDIS_HOST=

# Đổi các driver sang redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
CACHE_STORE=redis
DEVELOPER_CACHE_STORE=redis

# mo rong
## file
APP_MAINTENANCE_DRIVER=cache
APP_MAINTENANCE_STORE=redis

## debug
LOG_LEVEL=error
```
# composer.json
vi composer.json

```
"require": {
        "ncc/packages-ncc": "dev-main"
    },
    "repositories": [
        {
            "type": "path",
            "url": "../packages-ncc",
            "options": {
                "symlink": true
            }
        }
    ],
```
# view / welcom
vi routes/web.php

# run
composer update

composer dump-autoload

php artisan migrate

php artisan optimize:clear

## lenh toi uu prod
composer install --no-dev --optimize-autoloader

php artisan optimize:clear

php artisan config:cache

php artisan route:cache

php artisan view:cache

php artisan event:cache

php artisan octane:reload

## note fix
apk add --no-cache php84-redis

tail -n 10 /var/www/html/laravel-app/storage/logs/laravel.log

APP_DEBUG=true

php artisan tinker

Cache::store('redis')->put('test-key', 'Xuan 2026', 10);

Cache::store('redis')->get('test-key');

services:
  laravel-app:
    # ... các cấu hình khác
    environment:
      - TZ=Asia/Ho_Chi_Minh

  redis-alpine-ncc-prod:
    # ... các cấu hình khác
    environment:
      - TZ=Asia/Ho_Chi_Minh

## fix image rankmath
```
# 1. Tạo thư mục mu-plugins (Cờ -p giúp tự sinh nếu chưa có)
mkdir -p /var/www/html/wp-app/wp-content/mu-plugins

# 2. Tạo file PHP cấu hình bên trong đó
cat << 'EOF' > /var/www/html/wp-app/wp-content/mu-plugins/kill-image-crops.php
<?php
/*
Plugin Name: Kill Image Crops System
Description: Chặn đứng hoàn toàn việc tự ý sinh ảnh rác của WP Core, RankMath và WooCommerce để tiết kiệm dung lượng ổ cứng.
Version: 1.0
Author: Solution Architect
*/

// 1. Chặn RankMath tự ý cắt ảnh phục vụ social (Facebook/Twitter)
add_filter('rank_math/frontend/social_image_sizes', function($sizes) {
    return [];
});

// 2. Chặn đứng TẤT CẢ các bên thứ ba (Theme, WooCommerce, các plugin khác) tự ý tạo size ảnh mới
add_filter('intermediate_image_sizes_advanced', function($sizes) {
    return [];
});
EOF
```

ls /var/www/html/wp-app/wp-content/uploads/2026/06

# fix ver 2

vi /var/www/html/wp-app/wp-content/mu-plugins/kill-image-crops.php
```
<?php
/*
Plugin Name: Custom Image Crops System
Description: Chỉ cho phép giữ lại duy nhất size Thumbnail, chặn sạch các size lớn rác khác.
Version: 1.1
*/

// Tinh chỉnh bộ lọc nâng cao của WordPress Core & các plugin khác
add_filter('intermediate_image_sizes_advanced', function($sizes) {
    
    // MẸO: Trích xuất giữ lại cấu hình của riêng thằng 'thumbnail'
    $thumbnail_size = isset($sizes['thumbnail']) ? $sizes['thumbnail'] : null;

    // Xóa sạch toàn bộ danh sách các size khác (medium, large, woocommerce_single,...)
    $sizes = [];

    // Nếu hệ thống có định nghĩa size thumbnail, ta nhét nó ngược lại vào mảng cho phép chạy
    if ($thumbnail_size) {
        $sizes['thumbnail'] = $thumbnail_size;
    }

    return $sizes;
});
```

ls /var/www/html/wp-app/wp-content/uploads/2026/06