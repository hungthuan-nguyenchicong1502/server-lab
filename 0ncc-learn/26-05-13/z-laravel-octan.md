server {
    listen 80;
    server_name your-domain.local; # Hoặc IP của con T420

    location / {
        proxy_pass http://127.0.0.1:8000; # Đẩy request sang Octane
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

ab -n 1000 -c 10 http://127.0.0.1/

use Illuminate\Support\Facades\URL;

public function boot()
{
    if (config('app.env') !== 'local') {
        URL::forceScheme('https');
    }
}


FROM $(LARAVEL_NAME)

# Cài đặt extension cần thiết cho Octane & Swoole
RUN apk add --no-cache \
    php84-pecl-swoole \
    php84-pcntl \
    php84-posix \
    php84-tokenizer \
    php84-session

WORKDIR /laravel-app

COPY ./laravel-octane.sh /usr/local/bin/laravel-octane.sh
RUN chmod +x /usr/local/bin/laravel-octane.sh

ENTRYPOINT ["/usr/local/bin/laravel-octane.sh"]

# Giữ nguyên CMD
CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=8000"]

## laravel-octane.conf

map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}

server {
    listen 80;
    server_name your-domain.local; # Thay bằng domain của bạn
    root /var/www/html/public; # Đường dẫn đến thư mục public của Laravel

    index index.php;
    charset utf-8;

    location /index.php {
        try_files /not_exists @octane;
    }

    location / {
        try_files $uri $uri/ @octane;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/your-domain.error.log error;

    error_page 404 /index.php;

    location @octane {
        set $suffix "";

        if ($uri = /index.php) {
            set $suffix ?$query_string;
        }

        proxy_http_version 1.1;
        proxy_set_header Host $http_host;
        proxy_set_header Scheme $scheme;
        proxy_set_header SERVER_PORT $server_port;
        proxy_set_header REMOTE_ADDR $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;

        # 'laravel-octane-alpine-ncc' là tên container Octane của bạn
        proxy_pass http://laravel-octane-alpine-ncc:8000$suffix;
    }
}

vi config/octane.php

# Cài đặt công cụ đo
apk add curl

# Đo thời gian phản hồi tại chỗ (localhost của container)
curl -o /dev/null -s -w 'Total time: %{time_total}s\n' http://127.0.0.1:1000/test

# Cài đặt wrk để đo hiệu năng
apk add wrk

# Chạy thử 400 kết nối đồng thời trong 30 giây
wrk -t12 -c400 -d30s http://127.0.0.1:1000/test

docker exec laravel-octane-alpine-ncc php artisan octane:status

docker exec laravel-octane-alpine-ncc apk add --no-cache curl

docker exec laravel-octane-alpine-ncc time curl -o /dev/null -s http://127.0.0.1:1000/test

docker exec laravel-octane-alpine-ncc php artisan optimize:clear

docker exec laravel-octane-alpine-ncc php artisan octane:reload

SESSION_DRIVER=database  # Bây giờ dùng MariaDB nên database sẽ nhanh hơn file nhiều
# Hoặc nếu không cần lưu session phức tạp:
SESSION_DRIVER=cookie

php artisan config:cache
php artisan route:cache
php artisan view:cache