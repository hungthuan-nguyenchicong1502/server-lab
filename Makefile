
.DEFAULT_GOAL :=help
PROJECT_DIR = $(shell dirname $(PWD))
PROJECT_NAME = ncc-lab-project
PROJECT_PATH = $(PROJECT_DIR)/$(PROJECT_NAME)
# docker network
MY_APP_NET = my-app-net
# alpine_image => Using default tag: latest
# docker pull alpine
ALPINE_IMAGE = alpine

# include
include cloudflared-tunnel/cloudflared-tunnel.mk

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

project-ls:
	@echo "project-ls"
	ls $(PROJECT_PATH)

setup: _prepare
	@echo "setup"
# 	$(MAKE) cloudflared-tunnel-setup

up:
	@echo "up"
	$(MAKE) cloudflared-tunnel-up

down:
	@echo "down"
	$(MAKE) cloudflared-tunnel-down
