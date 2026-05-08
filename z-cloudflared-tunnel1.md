# cloudflared-tunnel 1

_cloudflared-tunnel-prepare:
	@echo "_cloudflared-tunnel-prepare"
	mkdir -p $(CLOUNDFLARED_TUNNEL_PROJECT_PATH)
	@echo "create .env"
	@if [ ! -f $(CLOUNDFLARED_TUNNEL_PROJECT_PATH)/.env ]; then \
		echo "create .env"; \
		read -p "Enter your Cloundflare Tunnel Token: " token; \
		if [ -z "$$token" ]; then \
			echo "Error: Token cannot be empty!"; exit 1; \
		fi; \
		echo "TUNNEL_TOKEN=$$token" > $(CLOUNDFLARED_TUNNEL_PROJECT_PATH)/.env; \
		echo ".env file create successfully."; \
	else \
		echo ".env file already exists. Skipping manual input."; \
	fi

cloudflared-tunnel-update-env:
	@echo "cloudflared-tunnel-update-env"
	@if [ -f $(CLOUNDFLARED_TUNNEL_PROJECT_PATH)/.env ]; then \
		echo "update .env"; \
		vi $(CLOUNDFLARED_TUNNEL_PROJECT_PATH)/.env; \
		echo ".env file update successfully."; \
	else \
		echo ".env file not found"; exit 1; \
	fi

	@echo "Reload Cloundflared-tunnel"
	$(MAKE) cloudflared-tunnel-down
	$(MAKE) cloudflared-tunnel-up

# cloudflared-tunnel/_create-docker-compose-yml.mk

define CLOUNDFLARED_TUNNEL_DOCKER_COMPOSE_YML
services:
 $(CLOUNDFLARED_TUNNEL_NAME):
  image: cloudflare/cloudflared:latest
  container_name: $(CLOUNDFLARED_TUNNEL_NAME)
  restart: always
  networks:
   - $(CLOUNDFLARED_TUNNEL_NAME)-net
  command: tunnel --no-autoupdate run --token $${TUNNEL_TOKEN}

networks:
 $(CLOUNDFLARED_TUNNEL_NAME)-net:
  external: true
  # docker create network MY_APP_NET
  name: $(MY_APP_NET)
endef

export CLOUNDFLARED_TUNNEL_DOCKER_COMPOSE_YML

_cloudflared-tunnel-create-docker-compose-yml:
	@echo "_cloudflared-tunnel-create-docker-compose-yml"
	echo "$$CLOUNDFLARED_TUNNEL_DOCKER_COMPOSE_YML" > $(CLOUNDFLARED_TUNNEL_PROJECT_PATH)/docker-compose.yml

@printf "%s\n" "$$VAR" > file