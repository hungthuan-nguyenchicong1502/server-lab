# cloudflared-tunnel/_create-env.mk
# use
# CLOUDFLARED_TUNNEL_PROJECT_PATH

_cloudflared-tunnel/_create-env.mk-create-env-default:
	@echo "_cloudflared-tunnel/_create-env.mk-create-env-default"
	if [ ! -f ./cloudflared-tunnel/.env.default ]; then\
		echo "create .env.default"; \
		echo "TUNNEL_TOKEN=insert-token" > ./cloudflared-tunnel/.env.default; \
	fi

_cloudflared-tunnel/_create-env.mk-create-project-env: _cloudflared-tunnel/_create-env.mk-create-env-default
	@echo "_cloudflared-tunnel/_create-env.mk-create-project-env"
	if [ ! -f $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/.env ]; then \
		cp -f ./cloudflared-tunnel/.env.default $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/.env; \
		make _cloudflared-tunnel/_create-env.mk-update-project-env; \
	else \
		echo ".env file already exists"; \
		make _cloudflared-tunnel/_create-env.mk-update-project-env; \
	fi

_cloudflared-tunnel/_create-env.mk-remove-project-env:
	@echo "_cloudflared-tunnel/_create-env.mk-remove-project-env"
	rm -f $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/.env

_cloudflared-tunnel/_create-env.mk-update-project-env:
	@echo "_cloudflared-tunnel/_create-env.mk-update-project-env"
	vi $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/.env

_cloudflared-tunnel/_create-env.mk:
	@echo "_cloudflared-tunnel/_create-env.mk"
	$(MAKE) _cloudflared-tunnel/_create-env.mk-create-project-env