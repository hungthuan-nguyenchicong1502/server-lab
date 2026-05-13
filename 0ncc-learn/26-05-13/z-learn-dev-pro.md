# build: !reset null 
services:
  php-fpm:
    image: php-fpm-alpine-ncc-dev
    volumes:
      - ./code:/var/www/html/code # Gắn code từ host vào PHP để dev
      - shared-code:/var/www/html/code # Đồng bộ nó vào volume chung

  nginx:
    image: nginx-alpine-ncc-dev
    volumes:
      - shared-code:/var/www/html/code:ro # Nginx chỉ cần đọc (read-only) từ volume chung

services:
  php-fpm:
    build:
      context: ../ # Đẩy context ra thư mục gốc để thấy được ./volumes
      dockerfile: php-fpm/Dockerfile
    # Không dùng volumes nữa, code đã được COPY vào image

  nginx:
    build:
      context: ../
      dockerfile: nginx/Dockerfile

# --- Stage 1: App Source ---
FROM alpine AS source
COPY ./volumes/project-app /app

# --- Stage 2: PHP-FPM ---
FROM php:8.4-fpm-alpine
COPY --from=source /app /var/www/html

# --- Stage 3: Nginx ---
FROM nginx:alpine
COPY --from=source /app /var/www/html

docker exec -it php-fpm-alpine-ncc-dev chown -R www-data:www-data /var/www/html
docker exec -it php-fpm-alpine-ncc-dev chmod -R 755 /var/www/html

user: "${UID}:${GID}" # Ép container chạy bằng ID của bạn ở ngoài

## fix fpm

sudo usermod -aG nobody cong

docker
sudo usermod -aG nobody 1000
docker exec -it php-fpm-alpine-ncc-dev chmod -R 775 /var/www/html
docker exec -it php-fpm-alpine-ncc-dev chown -R nobody:nobody /var/www/html