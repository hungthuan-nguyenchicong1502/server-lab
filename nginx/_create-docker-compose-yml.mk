# nginx/_create-docker-compose-yml.mk

define NGINX_DOCKER_COMPOSE_YML
services:
 $(NGINX_NAME):
  build:
   context: .
   dockerfile: Dockerfile

  image: $(NGINX_NAME)
  container_name: $(NGINX_NAME)

  networks:
   - $(NGINX_NAME)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html
   - $(NGINX_VOLUMES_CONF):/etc/nginx/http.d

networks:
 $(NGINX_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export NGINX_DOCKER_COMPOSE_YML

_nginx/_create-docker-compose-yml.mk:
	@echo "_nginx/_create-docker-compose-yml.mk"
	printf "$$NGINX_DOCKER_COMPOSE_YML" > $(NGINX_PROJECT_PATH)/docker-compose.yml