# Makefile
-include ./.env

.DEFAULT_GOAL :=help
PROJECT_DIR = $(shell dirname $(PWD))
PROJECT_NAME = project-server-lab
PROJECT_PATH = $(PROJECT_DIR)/$(PROJECT_NAME)
VOLUMES_PROJECT = $(PROJECT_PATH)/volumes
VOLUMES_PROJECT_APP = $(VOLUMES_PROJECT)/project-app
# docker network
MY_APP_NET = my-app-net
# alpine_image => Using default tag: latest
# docker pull alpine
ALPINE_IMAGE = alpine

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
include z-git-dev/git-dev.mk

dd:
	@echo "$(PROJECT_DIR)"

help:
	@echo "make cloudflared-tunnel-setup"

_check-network:
	@echo "_check-network"
	docker network inspect $(MY_APP_NET) >/dev/null 2>&1 || docker network create $(MY_APP_NET)

_prepare:
	@echo "prepare"
	mkdir -p $(PROJECT_PATH)
	mkdir -p $(VOLUMES_PROJECT)
	mkdir -p $(VOLUMES_PROJECT_APP)

project-ls:
	@echo "project-ls"
	ls $(PROJECT_PATH)
	ls $(VOLUMES_PROJECT_APP)

setup: _prepare
	@echo "setup"
	$(MAKE) _check-network
	docker pull $(ALPINE_IMAGE)

	$(MAKE) cloudflared-tunnel-setup
	$(MAKE) nginx-setup
	$(MAKE) php-fpm-setup
	$(MAKE) mariadb-setup
	$(MAKE) wp-cli-setup

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
# 	$(MAKE) nginx-down
# 	$(MAKE) php-fpm-down
# 	$(MAKE) mariadb-down

down-v:
	@echo "down-v"
	$(MAKE) nginx-down-v
	$(MAKE) php-fpm-down-v
	$(MAKE) mariadb-down-v
