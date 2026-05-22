# cloudflared-tunnel/cloudflared-tunnel.mk

CLOUDFLARED_TUNNEL_NAME := cloudflared-tunnel-alpine-ncc
CLOUDFLARED_TUNNEL_PROJECT_PATH := $(SHARE_PROJECT_PATH)/cloudflared-tunnel
# docker-compose-yml
CLOUDFLARED_TUNNEL_NAME_APP_ENV := $(CLOUDFLARED_TUNNEL_NAME)
# include 
include cloudflared-tunnel/_create-env.mk
include cloudflared-tunnel/_define-docker-compose-yml.mk
include cloudflared-tunnel/_docker-compose.mk

cloudflared-tunnel-help:
	@echo "make cloudflared-tunnel-setup"
	@echo "make cloudflared-tunnel-up"
	@echo "make cloudflared-tunnel-down"
	@echo "make cloudflared-tunnel-update-env"

_cloudflared-tunnel-prepare: _prepare
	@echo "_cloudflared-tunnel-prepare"
	mkdir -p $(CLOUDFLARED_TUNNEL_PROJECT_PATH)

cloudflared-tunnel-setup: _cloudflared-tunnel-prepare
	@echo "cloudflared-tunnel-setup"
	make _cloudflared-tunnel/_create-env.mk
	sleep 1
	make _cloudflared-tunnel/_docker-compose.mk
	sleep 1

cloudflared-tunnel-up:
	@echo "cloudflared-tunnel-up"
	make _cloudflared-tunnel/_docker-compose.mk-up

cloudflared-tunnel-down:
	@echo "cloudflared-tunnel-down"
	make _cloudflared-tunnel/_docker-compose.mk-down

# $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/.env
cloudflared-tunnel-cat-env:
	@echo "cloudflared-tunnel-cat-env"
	cat $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/.env

cloudflared-tunnel-update-env:
	@echo "cloudflared-tunnel-update-env"
	make _cloudflared-tunnel-update-env