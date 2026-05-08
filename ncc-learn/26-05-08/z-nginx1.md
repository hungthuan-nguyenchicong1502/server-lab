FROM alpine:latest

# Ghi đè file repositories bằng các link mirror mới
RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\n" > /etc/apk/repositories

# Sau đó bạn có thể cài đặt gói bình thường
RUN apk update && apk add --no-cache curl

WORKDIR /var/www/html

RUN chmod +x /var/www/html

CMD ["nginx", "-g", "daemon off;"]

FROM alpine:latest

# Cài đặt nginx
RUN apk add --no-cache nginx

# Bước quan trọng: Chuyển hướng log file ra stdout và stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Cấu hình chạy nginx
CMD ["nginx", "-g", "daemon off;"]

define WP_APP_DOCKER_COMPOSE_YML
services:
 $(WP_APP_NAME):
  build:
   context: .
   dockerfile: Dockerfile

  image: $(WP_APP_NAME)
  container_name: $(WP_APP_NAME)

  networks:
   - $(WP_APP_NAME)-net

  volumes:
   - $(VOLUMES_HTML)/wp-app:/var/www/html/wp-app
   - $(NGINX_VOLUMES_CONF):/etc/nginx/http.d

   RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\n\
https://mirror.leaseweb.com/alpine/latest-stable/community\n" \
> /etc/apk/repositories

# Tắt việc chờ đợi dữ liệu đầy buffer
proxy_buffering off;

# Giữ kết nối mở để không phải thiết lập lại từ đầu (Keep-alive)
proxy_http_version 1.1;
proxy_set_header Connection "";

https://dnsviz.net/