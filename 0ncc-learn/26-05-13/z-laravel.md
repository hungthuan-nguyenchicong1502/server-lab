docker exec -it laravel-alpine-ncc sh

composer create-project laravel/laravel:^12 laravel-app

rm -rf laravel-app
# ext
apk add \
    php84-tokenizer \
    php84-session \
    php84-dom \
    php84-xml \
    php84-xmlwriter \
    php84-fileinfo \
    php84-pdo \
    php84-pdo_sqlite \
    php84-pdo_mysql

cd laravel-app

php artisan serve --host=0.0.0.0 --port=8000

# test octan

composer require laravel/octane

php artisan octane:install

php artisan octane:start --host=0.0.0.0 --port=8000

apk add php84-pecl-swoole

vi .env

OCTANE_SERVER=swoole

apk add php84-pcntl

php artisan optimize:clear

php artisan octane:install --server=swoole --force

php artisan octane:start --host=0.0.0.0 --port=8000

rm -f storage/logs/octane-server.pid

apk add php84-posix

php artisan octane:start --server=swoole --host=0.0.0.0 --port=8000

## fix

apk add php84-pecl-swoole
apk add php84-pcntl
apk add php84-posix

apk add \
    php84-pecl-swoole \
    php84-pcntl \
    php84-posix

composer require laravel/octane

php artisan octane:install

php artisan octane:install --server=swoole --force

php artisan octane:start --server=swoole --host=0.0.0.0 --port=8000

## wathc
# Cài đặt Node.js và npm nếu chưa có
apk add nodejs npm

# Cài đặt thư viện chokidar toàn cục hoặc trong dự án
npm install --save-dev chokidar

php artisan octane:start --server=swoole --host=0.0.0.0 --port=8000 --watch

# Chạy ngầm
php artisan octane:start --server=swoole --host=0.0.0.0 --port=8000 --watch &

php artisan octane:start --server=swoole --host=0.0.0.0 --port=8000 --watch > /dev/null 2>&1 &

# Sửa một đoạn văn bản trong file welcome
sed -i 's/Laravel/Laravel Octane Power abc/g' resources/views/welcome.blade.php

php artisan octane:reload

php artisan octane:stop

netstat -tuln | grep 8000

# Chạy nền và lưu log vào file
php artisan octane:start --server=swoole --host=0.0.0.0 --port=8000 --watch > storage/logs/octane_runtime.log 2>&1 &

export OCTANE_SERVER=swoole && php artisan octane:install --server=swoole --force

public function boot(): void
{
    if (isset($_SERVER['LARAVEL_OCTANE'])) {
        $_ENV['OCTANE_SERVER'] = 'swoole';
    }
}

php artisan octane:install --server=swoole --force