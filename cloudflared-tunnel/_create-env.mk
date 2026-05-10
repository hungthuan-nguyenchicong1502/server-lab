# cloudflared-tunnel/_create-env.mk

_cloudflared-tunnel/_create-env.mk:
	@echo "_cloudflared-tunnel/_create-env.mk"
	@echo "TUNNEL_TOKEN=$(TUNNEL_TOKEN)" > $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/.env
