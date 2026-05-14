# nginx/_define_docker-file.mk

# main
define NGINX_DOCKERFILE
FROM $(ALPINE_IMAGE)

RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.leaseweb.com/g' /etc/apk/repositories

RUN apk update && apk add --no-cache

RUN apk add --no-cache \
	nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /var/www/html

CMD ["nginx", "-g", "daemon off;"]
endef

export NGINX_DOCKERFILE

# dev
define NGINX_DOCKERFILE_DEV
FROM $(ALPINE_IMAGE)

RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.leaseweb.com/g' /etc/apk/repositories

RUN apk update && apk add --no-cache

RUN apk add --no-cache \
	nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /var/www/html

CMD ["nginx", "-g", "daemon off;"]
endef

export NGINX_DOCKERFILE_DEV