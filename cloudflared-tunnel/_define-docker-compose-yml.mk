# cloudflared-tunnel/_define-docker-compose-yml.mk

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