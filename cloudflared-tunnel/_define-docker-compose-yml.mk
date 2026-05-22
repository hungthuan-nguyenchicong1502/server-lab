# cloudflared-tunnel/_define-docker-compose-yml.mk

define CLOUDFLARED_TUNNEL_DOCKER_COMPOSE_YML
services:
 $(CLOUDFLARED_TUNNEL_NAME_APP_ENV):
  image: cloudflare/cloudflared:latest
  container_name: $(CLOUDFLARED_TUNNEL_NAME_APP_ENV)
  restart: always
  networks:
   - $(CLOUDFLARED_TUNNEL_NAME_APP_ENV)-net
  environment:
   - TUNNEL_TOKEN=$${TUNNEL_TOKEN}
  command: tunnel run

networks:
 $(CLOUDFLARED_TUNNEL_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export CLOUDFLARED_TUNNEL_DOCKER_COMPOSE_YML