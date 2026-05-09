
.DEFAULT_GOAL :=help
PROJECT_DIR = $(shell dirname $(PWD))
PROJECT_NAME = ncc-lab-project
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

dd:
	@echo "$(PROJECT_DIR)"

help:
	@echo "make cloudflared-tunnel-setup"

_check-network:
	@echo "_check-network"
	docker network inspect $(MY_APP_NET) >/dev/null 2>&1 || docker network create $(MY_APP_NET)

_prepare:
	@echo "prepare"
	$(MAKE) _check-network
	mkdir -p $(PROJECT_PATH)
	docker pull $(ALPINE_IMAGE)
	mkdir -p $(VOLUMES_PROJECT)
	mkdir -p $(VOLUMES_PROJECT_APP)

project-ls:
	@echo "project-ls"
	ls $(PROJECT_PATH)

setup: _prepare
	@echo "setup"
# 	$(MAKE) cloudflared-tunnel-setup
	$(MAKE) nginx-setup
	$(MAKE) php-fpm-setup
	$(MAKE) mariadb-setup

	docker ps

up:
	@echo "up"
	$(MAKE) cloudflared-tunnel-up
	$(MAKE) nginx-up
	$(MAKE) php-fpm-up
	$(MAKE) mariadb-up

down:
	@echo "down"
	$(MAKE) cloudflared-tunnel-down
	$(MAKE) nginx-down
	$(MAKE) php-fpm-down
	$(MAKE) mariadb-down

down-v:
	@echo "down-v"
	$(MAKE) nginx-down-v
	$(MAKE) php-fpm-down-v
	$(MAKE) mariadb-down-v
