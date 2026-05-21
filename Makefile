# Makefile
-include ./.env

.DEFAULT_GOAL :=help
PROJECT_DIR := $(shell dirname $(PWD))
PROJECT_NAME := project-server-lab
PROJECT_PATH := $(PROJECT_DIR)/$(PROJECT_NAME)
VOLUMES_PROJECT := $(PROJECT_PATH)/volumes
VOLUMES_PROJECT_APP := $(VOLUMES_PROJECT)/project-app
# share
SHARE_PATH := $(HOME)/share
SHARE_PROJECT_PATH := $(SHARE_PATH)/$(PROJECT_NAME)
# volumes app
VOLUMES_NGINX_CONF := $(VOLUMES_PROJECT)/nginx-conf
VOLUMES_WP_APP := $(VOLUMES_PROJECT_APP)/wp-app
VOLUMES_LARAVEL_APP := $(VOLUMES_PROJECT_APP)/laravel-app
# docker network
MY_APP_NET := my-app-net
# alpine_image => Using default tag: latest
# docker pull alpine
ALPINE_IMAGE := alpine
# test:
# 	echo $(SHARE_PATH)
# include
include cloudflared-tunnel/cloudflared-tunnel.mk
include nginx/nginx.mk
include php-fpm/php-fpm.mk
include mariadb/mariadb.mk
include wp-cli/wp-cli.mk
include wp-app/wp-app.mk
include laravel/laravel.mk
include laravel-octane/laravel-octane.mk
include redis/redis.mk

# app env
include git-dev/git-dev.mk
include z-git-dev/git-dev.mk
# app env feature
include git-feature/git-feature.mk
# app env prod
include git-prod/git-prod.mk

dd:
	@echo "$(PROJECT_DIR)"

help:
	@echo "make setup"
	@echo "make cloudflared-tunnel-help"

_check-network:
	@echo "_check-network"
	docker network inspect $(MY_APP_NET) >/dev/null 2>&1 || docker network create $(MY_APP_NET)

_prepare:
	@echo "prepare"
	mkdir -p $(PROJECT_PATH)
	mkdir -p $(VOLUMES_PROJECT)
	mkdir -p $(VOLUMES_PROJECT_APP)
	mkdir -p $(SHARE_PATH)
	mkdir -p $(SHARE_PROJECT_PATH)
	mkdir -p $(VOLUMES_NGINX_CONF)
	mkdir -p $(VOLUMES_WP_APP)
	mkdir -p $(VOLUMES_LARAVEL_APP)

project-ls:
	@echo "project-ls"
	ls $(PROJECT_PATH)
	ls $(VOLUMES_PROJECT_APP)

setup: _prepare
	@echo "setup"
	$(MAKE) _check-network
	docker pull $(ALPINE_IMAGE)
	sleep 1
	$(MAKE) cloudflared-tunnel-setup
	sleep 1
	$(MAKE) mariadb-setup
	sleep 1
	$(MAKE) nginx-setup
	sleep 1
	$(MAKE) php-fpm-setup
	sleep 1
	$(MAKE) wp-cli-setup
	sleep 1
	$(MAKE) wp-app-setup
	sleep 1
	make laravel-setup
	sleep 1
	make laravel-octane-setup
	sleep 1
	make nginx-down
	sleep 1
	make nginx-up
	

	docker ps

up:
	@echo "up"
	$(MAKE) cloudflared-tunnel-up
# 	$(MAKE) nginx-up
# 	$(MAKE) php-fpm-up
# 	$(MAKE) mariadb-up

down:
	@echo "down"
	$(MAKE) cloudflared-tunnel-down
	$(MAKE) mariadb-down
	$(MAKE) nginx-down
	$(MAKE) php-fpm-down
	make laravel-down
	make laravel-octane-down

down-v:
	@echo "down-v"
	$(MAKE) nginx-down-v
	$(MAKE) php-fpm-down-v
	$(MAKE) mariadb-down-v

remove-project-path:
	@echo "remove-project-path"
	docker run -u root --rm -v $(VOLUMES_PROJECT):/parent $(ALPINE_IMAGE) sh -c "\
		chown -R root:root /parent; \
		chmod -R 777 /parent; \
		rm -rf /parent/volumes"
	rm -rf $(PROJECT_PATH)
