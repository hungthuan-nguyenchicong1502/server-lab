make laravel-octane-sh

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

composer update

php artisan migrate

php artisan optimize:clear

php artisan octane:reload

## volumes packages-ncc

working_dir: $(LARAVEL_OCTANE_WORKDIR)
  
  volumes:
   - $(VOLUMES_LARAVEL_APP):$(LARAVEL_OCTANE_WORKDIR)
   - $(VOLUMES_PACKAGES_NCC):$(PACKAGES_NCC_WORKDIR)

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

composer update

composer dump-autoload

php artisan migrate

php artisan optimize:clear
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