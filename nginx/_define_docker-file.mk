# nginx/_define_docker-file.mk

# main
define NGINX_DOCKER_FILE
FROM $(ALPINE_IMAGE)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" > /etc/apk/repositories

RUN apk update && apk upgrade

RUN apk add --no-cache \
	nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR $(NGINX_WORKDIR)

CMD ["nginx", "-g", "daemon off;"]
endef

export NGINX_DOCKER_FILE

# dev
define NGINX_DOCKERFILE_DEV
FROM $(NGINX_NAME)

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" > /etc/apk/repositories

RUN apk update && apk upgrade

WORKDIR $(NGINX_WORKDIR)

CMD ["nginx", "-g", "daemon off;"]
endef

export NGINX_DOCKERFILE_DEV

# feature
define NGINX_DOCKERFILE_FEATURE
FROM $(NGINX_NAME)-dev

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" > /etc/apk/repositories

RUN apk update && apk upgrade

WORKDIR $(NGINX_WORKDIR)

CMD ["nginx", "-g", "daemon off;"]
endef

export NGINX_DOCKERFILE_FEATURE

# prod
define NGINX_DOCKERFILE_PROD
FROM $(NGINX_NAME)-dev

RUN printf "https://mirror.leaseweb.com/alpine/latest-stable/main\\nhttps://mirror.leaseweb.com/alpine/latest-stable/community\\n" > /etc/apk/repositories

RUN apk update && apk upgrade

WORKDIR $(NGINX_WORKDIR)

CMD ["nginx", "-g", "daemon off;"]
endef

export NGINX_DOCKERFILE_PROD