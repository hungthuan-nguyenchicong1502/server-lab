# cloudflared-tunnel/_create-docker-compose-yml.mk
# use
# CLOUDFLARED_TUNNEL_NAME
# CLOUDFLARED_TUNNEL_PROJECT_PATH

define CLOUDFLARED_TUNNEL_DOCKER_COMPOSE_YML
services:
 $(CLOUDFLARED_TUNNEL_NAME):
  image: cloudflare/cloudflared:latest
  container_name: $(CLOUDFLARED_TUNNEL_NAME)
  restart: always
  networks:
   - $(CLOUDFLARED_TUNNEL_NAME)-net
  environment:
   - TUNNEL_TOKEN=$${TUNNEL_TOKEN}
  command: tunnel run

networks:
 $(CLOUDFLARED_TUNNEL_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export CLOUDFLARED_TUNNEL_DOCKER_COMPOSE_YML

_cloudflared-tunnel/_create-docker-compose-yml.mk:
	@echo "_cloudflared-tunnel/_create-docker-compose-yml.mk"
	printf "$$CLOUDFLARED_TUNNEL_DOCKER_COMPOSE_YML" > $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/docker-compose.yml

_cloudflared-tunnel/_create-docker-compose-yml.mk-cat:
	@echo "_cloudflared-tunnel/_create-docker-compose-yml.mk-cat"
	cat $(CLOUDFLARED_TUNNEL_PROJECT_PATH)/docker-compose.yml