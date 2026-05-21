# nginx/nginx.mk
NGINX_NAME := nginx-alpine-ncc
NGINX_PROJECT_PATH := $(PROJECT_PATH)/nginx
# Dockerfile
NGINX_VERSION := v1.0.0
NGINX_WORKDIR := /var/wwww/html
# docker-compose.yml
NGINX_NAME_APP_ENV := $(NGINX_NAME)-$(APP_ENV)
NGINX_DOCKERFILE := Dockerfile.$(APP_ENV)
NGINX_IMAGE := $(NGINX_NAME_APP_ENV)-$(NGINX_VERSION)
# use $(NGINX_VOLUMES_CONF):/etc/nginx/http.d
NGINX_VOLUMES_CONF := $(VOLUMES_PROJECT)/nginx-conf

ifeq ($(APP_ENV), feature)
	NGINX_WORKDIR := /home/project
endif

# include
include nginx/_define_docker-file.mk
include nginx/_define-docker-compose-yml.mk
include nginx/_docker-compose.mk

# test
include nginx/nginx-test/nginx-test.mk

# app env dev
# include nginx/nginx-app-env-dev/nginx-app-env-dev.mk

# test:
# 	echo $(NGINX_NAME_APP_NAME)

_nginx-prepare: _prepare
	@echo "_nginx-prepare"
	mkdir -p $(NGINX_PROJECT_PATH)
	mkdir -p $(NGINX_VOLUMES_CONF)

nginx-setup: _nginx-prepare
	@echo "nginx-setup"
	$(MAKE) _nginx/_docker-compose.mk

nginx-build:
	@echo "nginx-build"
	
nginx-up:
	@echo "nginx-up"
	$(MAKE) _nginx/_docker-compose.mk-up

nginx-down:
	@echo "nginx-down"
	$(MAKE) _nginx/_docker-compose.mk-down

nginx-down-v:
	@echo "nginx-down-v"
	$(MAKE) _nginx/_docker-compose.mk-down-v

nginx-conf-ls:
	ls $(NGINX_VOLUMES_CONF)

nginx-reload:
	sleep 1;
	docker exec $(NGINX_NAME_APP_ENV) nginx -s reload

nginx-restart:
	sleep 1;
	docker restart $(NGINX_NAME_APP_ENV)

nginx-logs:
	docker logs $(NGINX_NAME_APP_ENV)

nginx-t:
	docker exec $(NGINX_NAME_APP_ENV) nginx -t
