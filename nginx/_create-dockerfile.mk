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