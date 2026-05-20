# nginx/_define_docker-file.mk

# main
define NGINX_DOCKERFILE
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" > /etc/apk/repositories

RUN apk update && apk upgrade

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

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" > /etc/apk/repositories

RUN apk update && apk upgrade

RUN apk add --no-cache \
	nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /var/www/html

CMD ["nginx", "-g", "daemon off;"]
endef

export NGINX_DOCKERFILE_DEV

# feature
define NGINX_DOCKERFILE_FEATURE
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" > /etc/apk/repositories

RUN apk update && apk upgrade

RUN apk add --no-cache \
	nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir -p $(NGINX_WORKDIR_APP_NAME) && \
	chown -R root:nginx $(NGINX_WORKDIR_APP_NAME) && \
	chmod -R 775 $(NGINX_WORKDIR_APP_NAME)

WORKDIR $(NGINX_WORKDIR_APP_NAME)

CMD ["nginx", "-g", "daemon off;"]
endef

export NGINX_DOCKERFILE_FEATURE


# prod
define NGINX_DOCKERFILE_PROD
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" > /etc/apk/repositories

RUN apk update && apk upgrade

RUN apk add --no-cache \
	nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /var/www/html

CMD ["nginx", "-g", "daemon off;"]
endef

export NGINX_DOCKERFILE_PROD