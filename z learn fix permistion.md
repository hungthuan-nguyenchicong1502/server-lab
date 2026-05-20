FROM alpine:3.20

# Tạo group và user có UID/GID là 1000 trùng với máy host
RUN addgroup -g 1000 cong && \
    adduser -u 1000 -G cong -D cong

# (Tùy chọn) Chuyển quyền chạy các lệnh tiếp theo sang user này
USER cong


services:
  laravel-app:
    image: alpine:latest # Hoặc image php của bạn
    user: "1000:1000" # <--- Ép chạy bằng UID/GID của user 'cong' ngoài host
    volumes:
      - /home/cong/git-feature/project-server-lab/volumes/project-app:/home/project
    # ... các cấu hình khác

  user: "1000:1000"

build --no-cache

# Cài đặt thư viện quản lý bộ nhớ tối ưu cho Alpine
RUN apk add --no-cache jemalloc

# Thiết lập biến môi trường ép PHP sử dụng jemalloc
ENV LD_PRELOAD=/usr/lib/libjemalloc.so.2

docker compose exec laravel-app sh
cd /home/project/laravel-app

# Thử chạy lệnh khởi động của Octane xem nó báo lỗi cụ thể ở file nào:
php artisan octane:start

sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches

sync && echo 3 | tee /proc/sys/vm/drop_caches

# Nâng giới hạn số lượng file tối đa hệ thống có thể theo dõi cùng lúc
sudo sysctl -w fs.inotify.max_user_watches=524288
sudo sysctl -w fs.inotify.max_user_instances=512

# Nâng giới hạn file mở đồng thời (Tránh lỗi Too many open files)
sudo sysctl -w fs.file-max=2097152

# Lưu lại cấu hình vĩnh viễn để không bị mất khi reset máy
echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
echo "fs.inotify.max_user_instances=512" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p