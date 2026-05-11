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