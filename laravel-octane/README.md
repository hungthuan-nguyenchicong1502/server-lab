make laravel-octane-sh

vi .env

```
APP_ENV=prod

APP_DEBUG=false

APP_URL=http://localhost

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

## setup packages-ncc
make laravel-octane-sh

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
### view / welcom
vi routes/web.php

## laravel-octane-reload
make laravel-octane-reload

# note
composer install --no-de --optimize-autoloader

php artisan migrate

php artisan build-ncc -f

php artisan optimize:clear

php artisan octane:reload

composer update

composer dump-autoload

make laravel-octane-reload

## cache
php artisan config:cache

php artisan route:cache

php artisan view:cache

php artisan event:cache

composer update

php artisan migrate

php artisan optimize:clear

php artisan octane:reload

## docker compose
working_dir: $(LARAVEL_OCTANE_WORKDIR)
  
  volumes:
   - $(VOLUMES_LARAVEL_APP):$(LARAVEL_OCTANE_WORKDIR)
   - $(VOLUMES_PACKAGES_NCC):$(PACKAGES_NCC_WORKDIR)
## opcache.ini
```
opcache.enable=1
opcache.enable_cli=1        # Cực kỳ quan trọng vì Octane chạy qua giao diện CLI
opcache.memory_consumption=256
opcache.interned_strings_buffer=16
opcache.max_accelerated_files=20000
opcache.validate_timestamps=0 # Tắt hẳn việc check file thay đổi để đạt hiệu năng tối đa
```
# fix
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

services:
  laravel-app:
    # ... các cấu hình khác
    environment:
      - TZ=Asia/Ho_Chi_Minh

  redis-alpine-ncc-prod:
    # ... các cấu hình khác
    environment:
      - TZ=Asia/Ho_Chi_Minh