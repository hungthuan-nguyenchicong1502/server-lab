# cloudflared-tunnel/_docker-compose.mk

_cloudflared-tunnel/_docker-compose.mk:
	@echo "_cloudflared-tunnel/_docker-compose.mk"
	make _cloudflared-tunnel/_docker-compose.mk-create-docker-compose-yml

_cloudflared-tunnel/_docker-compose.mk-create-docker-compose-yml:
	@echo "_cloudflared-tunnel/_docker-compose.mk-create-docker-compose-yml"
	printf "$$CLOUDFLARED_TUNNEL_DOCKER_COMPOSE_YML" > $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/docker-compose.yml


_cloudflared-tunnel/_docker-compose.mk-up:
	@echo "_cloudflared-tunnel/_docker-compose.mk-up"
	docker compose -f $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(CLOUDFLARED_TUNNEL_PROJECT_PATH) \
		up -d

_cloudflared-tunnel/_docker-compose.mk-down:
	@echo "_cloudflared-tunnel/_docker-compose.mk-down"
	docker compose -f $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/docker-compose.yml \
		down