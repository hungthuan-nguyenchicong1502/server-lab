# Makefile
-include .env

.DEFAULT_GOAL :=help
PROJECT_DIR := $(shell dirname $(PWD))
PROJECT_NAME := project-server-lab
PROJECT_PATH := $(PROJECT_DIR)/$(PROJECT_NAME)
VOLUMES_PROJECT_PATH := $(PROJECT_PATH)/volumes
VOLUMES_PROJECT_APP_PATH := $(VOLUMES_PROJECT_PATH)/project-app
# share
SHARE_PATH := $(HOME)/share
SHARE_PROJECT_PATH := $(SHARE_PATH)/$(PROJECT_NAME)
# volumes app
VOLUMES_NGINX_CONF := $(VOLUMES_PROJECT_PATH)/nginx-conf
VOLUMES_WP_APP := $(VOLUMES_PROJECT_APP_PATH)/wp-app
VOLUMES_LARAVEL_APP := $(VOLUMES_PROJECT_APP_PATH)/laravel-app
# docker network
MY_APP_NET := my-app-net
# alpine_image => Using default tag: latest
# docker pull alpine
ALPINE_IMAGE := alpine

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
# packages-ncc => use laravel-app
include packages-ncc/packages-ncc.mk

# feature
include container-dev/container-dev.mk
include container-git-clone/container-git-clone.mk
# app env
include git/git.mk
include git-dev/git-dev.mk
include z-git-dev/git-dev.mk
# app env feature
include git-feature/git-feature.mk
# app env prod
include git-prod/git-prod.mk
# test
include make-test.mk

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
	mkdir -p $(VOLUMES_PROJECT_PATH)
	mkdir -p $(VOLUMES_PROJECT_APP_PATH)
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
	make _check-network
# 	sleep 1
	make cloudflared-tunnel-setup
# 	sleep 1
	make laravel-setup
# 	sleep 1
	make laravel-octane-setup
# 	sleep 1
	make mariadb-setup
# 	sleep 1
	make nginx-setup
# 	sleep 1
	make php-fpm-setup
# 	sleep 1
	make redis-setup
# 	sleep 1
	make wp-app-setup
# 	sleep 1
	make wp-cli-setup
	sleep 1

build:
	@echo "build"
	docker pull $(ALPINE_IMAGE)
	sleep 1
	make nginx-build
	sleep 1
	make php-fpm-build
	sleep 1
	make mariadb-build
	sleep 1
	make redis-build
	sleep 1
	make wp-cli-build
	sleep 1
	make wp-app-build
	sleep 1
	make laravel-build
	sleep 1
	make laravel-octane-build
	sleep 1

setting:
	@echo "setting"
	make mariadb-up
	sleep 10
	make php-fpm-up
	sleep 1
	make wp-app-create-wp-app
	sleep 1
	make laravel-create-laravel-app
	sleep 1
	make laravel-octane-setting
	sleep 1

up:
	@echo "up"
	make cloudflared-tunnel-up
	sleep 1
	make mariadb-up
	sleep 1
	make redis-up
	sleep 1
	make laravel-octane-up
	sleep 1
	make php-fpm-up
	sleep 5
	make nginx-up

down:
	@echo "down"
	make laravel-octane-down
	sleep 1
	make php-fpm-down
	sleep 1
	make mariadb-down
	sleep 1
	make redis-down
	sleep 1
	make nginx-down
	sleep 1
	make cloudflared-tunnel-down
	sleep 1

down-v:
	@echo "down-v"

# PROJECT_PATH
remove-project-path:
	@echo "remove-project-path"
	docker run -u root --rm -v $(PROJECT_PATH):/parent $(ALPINE_IMAGE) sh -c "\
		chown -R root:root /parent; \
		chmod -R 777 /parent; \
		rm -rf /parent/project-server-lab"
	rm -rf $(PROJECT_PATH)

# SHARE_PROJECT_PATH
remove-share-project-path:
	@echo "remove-project-path"
	docker run -u root --rm -v $(SHARE_PROJECT_PATH):/parent $(ALPINE_IMAGE) sh -c "\
		chown -R root:root /parent; \
		chmod -R 777 /parent; \
		rm -rf /parent/project-server-lab"
	rm -rf $(SHARE_PROJECT_PATH)