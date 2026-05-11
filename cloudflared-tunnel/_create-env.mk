# cloudflared-tunnel/_create-env.mk

_cloudflared-tunnel/_create-env.mk:
	@echo "_cloudflared-tunnel/_create-env.mk"
	@if [ -z "$(TUNNEL_TOKEN)" ]; then \
		echo "-->Error: .env TUNNEL_TOKEN"; exit 1; \
	else \
		printf "TUNNEL_TOKEN=$(TUNNEL_TOKEN)" > $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/.env; \
	fi

# test:
# 	ls $(CLOUDFLARED_TUNNEL_PROJECT_PATH) -a
# 	cat $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/.env