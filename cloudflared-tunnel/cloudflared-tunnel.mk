# cloudflared-tunnel/cloudflared-tunnel.mk

CLOUDFLARED_TUNNEL_NAME = cloudflared-tunnel-alpine-ncc
CLOUDFLARED_TUNNEL_PROJECT_PATH = $(SHARE_PROJECT_PATH)/cloudflared-tunnel

# include 
include cloudflared-tunnel/_create-env.mk
include cloudflared-tunnel/_define-docker-compose-yml.mk
include cloudflared-tunnel/_docker-compose.mk

cloudflared-tunnel-help:
	@echo "make cloudflared-tunnel-setup"
	@echo "make cloudflared-tunnel-up"
	@echo "make cloudflared-tunnel-down"
	@echo "make cloudflared-tunnel-update-env"

_cloudflared-tunnel-prepare:
	@echo "_cloudflared-tunnel-prepare"
	mkdir -p $(CLOUDFLARED_TUNNEL_PROJECT_PATH)

cloudflared-tunnel-setup: _cloudflared-tunnel-prepare
	@echo "cloudflared-tunnel-setup"
	$(MAKE) _cloudflared-tunnel/_create-env.mk
	$(MAKE) _cloudflared-tunnel/_docker-compose.mk

cloudflared-tunnel-up:
	@echo "cloudflared-tunnel-up"
	$(MAKE) _cloudflared-tunnel/_docker-compose.mk-up

cloudflared-tunnel-down:
	@echo "cloudflared-tunnel-down"
	$(MAKE) _cloudflared-tunnel/_docker-compose.mk-down
