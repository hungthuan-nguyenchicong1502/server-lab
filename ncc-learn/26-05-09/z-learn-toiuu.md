services:
  cloudflared:
    image: cloudflare/cloudflared:alpine
    # ... các cấu hình khác ...
    tmpfs:
      - /tmp
      - /var/log/cloudflared:uid=1000,gid=1000 # Đẩy log vào RAM
    environment:
      - TUNNEL_LOGLEVEL=error # Chỉ log lỗi để giảm I/O ghi

# Trong file nginx.conf hoặc site config
server {
    # Tăng kích thước buffer trong RAM để tránh ghi xuống đĩa tạm
    proxy_buffers 16 16k;
    proxy_buffer_size 32k;
    proxy_busy_buffers_size 64k;

    # Quan trọng: Tắt việc ghi buffer ra file nếu response quá lớn
    proxy_max_temp_file_size 0; 

    # Nếu bạn dùng FastCGI (cho PHP-FPM)
    fastcgi_buffers 16 16k;
    fastcgi_buffer_size 32k;
}

services:
  nginx:
    # ...
    volumes:
      - ./public/static:/usr/share/nginx/html/static:ro
    tmpfs:
      - /var/cache/nginx # Nạp cache của Nginx vào RAM

services:
  nginx-alpine-ncc:
    # ...
    logging:
      driver: "none" # Tắt sạch log của container này

  php-fpm-alpine-ncc:
    logging:
      driver: "none"

access_log off; # Tắt log truy cập (cái này tốn I/O nhất)
error_log /dev/null crit; # Chỉ ghi lỗi cực kỳ nghiêm trọng vào hư không

access.log = /dev/null
php_admin_value[error_log] = /dev/null
php_admin_flag[log_errors] = off


[mysqld]
    slow_query_log = 0
    log_error = /dev/null
    ```
*   **Cloudflare Tunnel:**
    Dùng biến môi trường trong Docker Compose để đưa log về mức thấp nhất:
    
```yaml
    environment:
      - TUNNEL_LOGLEVEL=fatal # Chỉ log khi sập tunnel
    ```

---

### 3. Cách "Bật lại khi cần" mà không làm gián đoạn hệ thống
Vì bạn ưu tiên hiệu năng và "pure code", bạn có thể dùng các mẹo sau để debug mà không cần sửa file config rồi restart container:

*   **Dùng biến môi trường để Toggle:**
    Bạn có thể đặt một biến `DEBUG=true` trong file `.env`. Trong config Nginx/PHP, bạn viết logic nếu `DEBUG=true` thì ghi log vào một volume được mount bằng `tmpfs` (RAM). Khi cần bật, chỉ cần đổi `.env` và `docker-compose up -d`.
*   **Sử dụng `docker logs --tail` (Nếu không dùng `driver: none`):**
    Nếu bạn để driver log là `json-file`, hãy giới hạn kích thước file log để không làm đầy ổ cứng:
    
```yaml
    logging:
      driver: "json-file"
      options:
        max-size: "1m"
        max-file: "1"
    ```
*   **Mẹo Debug "nóng":** 
    Nếu đang nghi ngờ lỗi ở PHP, thay vì xem log file, bạn có thể dùng lệnh `docker exec -it php-fpm-alpine-ncc php -m` hoặc chạy trực tiếp code để kiểm tra lỗi runtime ngay lập tức.

### Lời khuyên cho T420:
Việc tắt log sẽ giúp chỉ số `BLOCK I/O` trong `docker stats` của bạn gần như trở về **0B**. Khi đó, tốc độ phản hồi mà bạn thấy trong tab Network sẽ ổn định hơn, không còn bị "khựng" mỗi khi hệ thống bận ghi log vào cái ổ cứng HDD già nua nữa.

Nếu bạn muốn cấu hình "nửa bật nửa tắt" (ghi log vào RAM để xem xong mất luôn khi restart), tôi sẽ hướng dẫn bạn mount `/var/log` vào `tmpfs`. Bạn có muốn thử cách đó không?