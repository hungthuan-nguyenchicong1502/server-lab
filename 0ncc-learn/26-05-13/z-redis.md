FROM alpine:latest

# Cài đặt redis
RUN apk add --no-cache redis

# Copy file cấu hình tùy chỉnh (nếu có) hoặc dùng lệnh trực tiếp
# Ở đây ta sẽ điều chỉnh cấu hình mặc định để cho phép kết nối từ các container khác
RUN sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis.conf && \
    sed -i 's/protected-mode yes/protected-mode no/g' /etc/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]


services:
  # Service Redis
  redis:
    build:
      context: .
      dockerfile: Dockerfile.redis
    container_name: redis_server
    restart: unless-stopped
    networks:
      - app-network

  # Service Laravel Octane
  app:
    # ... (giữ nguyên cấu hình build của bạn)
    depends_on:
      - redis
    networks:
      - app-network
    env_file:
      - .env

networks:
  app-network:
    driver: bridge


Cấu hình file .env

CACHE_STORE=redis
REDIS_CLIENT=phpredis # Khuyến khích dùng phpredis để có hiệu suất cao nhất
REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379


config/database.php

'redis' => [
    'client' => env('REDIS_CLIENT', 'phpredis'),

    'options' => [
        'cluster' => env('REDIS_CLUSTER', 'redis'),
        'prefix' => env('REDIS_PREFIX', Str::slug(env('APP_NAME', 'laravel'), '_').'_database_'),
    ],

    'default' => [
        'url' => env('REDIS_URL'),
        'host' => env('REDIS_HOST', '127.0.0.1'),
        'username' => env('REDIS_USERNAME'),
        'password' => env('REDIS_PASSWORD'),
        'port' => env('REDIS_PORT', '6379'),
        'database' => env('REDIS_DB', '0'),
        'persistent' => true, // Bật kết nối bền vững rất quan trọng cho Octane
    ],
],

docker exec laravel-octane-alpine-ncc apk add --no-cache php84-pecl-redis php84-redis

## test octan
docker exec laravel-octane-alpine-ncc apk add --no-cache curl

docker exec laravel-octane-alpine-ncc time curl -o /dev/null -s http://127.0.0.1:1000/test

docker exec laravel-octane-alpine-ncc apk add --no-cache wrk

docker exec laravel-octane-alpine-ncc wrk -t12 -c400 -d30s http://127.0.0.1:1000/test

docker exec laravel-octane-alpine-ncc wrk -t2 -c400 -d10s http://127.0.0.1:1000/test

docker exec laravel-octane-alpine-ncc wrk -t1 -c400 -d10s http://127.0.0.1:1000/test

wrk -t8 -c8 -d1s http://172.17.0.1:1000/test

wrk -t4 -c400 -d5s https://hungthuan.com/test

# Tại thư mục dự án chính (nhánh develop)
git worktree add ../erp-prod main

git checkout [branch] -- [path] (Giống như cp -f)

git checkout main
git checkout dev -- app/Services/InventoryService.php  # Chỉ lấy 1 file
git checkout dev -- public/assets/                     # Lấy cả thư mục

git checkout main
    git cherry-pick abc1234

git restore --staged docs/
   # Hoặc nếu bạn muốn xóa luôn tài liệu đó khỏi thư mục làm việc hiện tại:
   git checkout main -- docs/