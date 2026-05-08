# nginx/_create-dockerfile.mk
define NGINX_DOCKERFILE
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" \\
	> /etc/apk/repositories

RUN apk update && apk add --no-cache

RUN apk add --no-cache \
	nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /var/www/html

CMD ["nginx", "-g", "daemon off;"]
endef

export NGINX_DOCKERFILE

_nginx/_create-dockerfile.mk:
	@echo "_nginx/_create-dockerfile.mk"
	printf "$$NGINX_DOCKERFILE" > $(NGINX_PROJECT_PATH)/Dockerfile

php84-fpm \
		php84-mysqli
		
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php84/php-fpm.d/www.conf

CMD ["php-fpm84", "-F", "-R"]

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Tạo user/group nếu chưa có (Alpine thường có sẵn nobody)
# Đảm bảo thư mục log/code thuộc về user này
RUN chown -R nobody:nobody /var/www/html /var/log/php84

# Chuyển sang user nobody
USER nobody

# Lúc này không cần -R nữa
CMD ["php-fpm84", "-F"]

-R [root]

docker exec php-fpm-alpine-ncc ps aux