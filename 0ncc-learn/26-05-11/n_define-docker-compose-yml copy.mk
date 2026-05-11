# nginx/_define-docker-compose-yml.mk

define NGINX_DOCKER_COMPOSE_YML
services:
 $(NGINX_NAME):
  build:
   context: .
   dockerfile: Dockerfile

  image: $(NGINX_NAME)
  container_name: $(NGINX_NAME)
  restart: always

  networks:
   - $(NGINX_NAME)-net

networks:
 $(NGINX_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export NGINX_DOCKER_COMPOSE_YML

# override
define NGINX_DOCKER_COMPOSE_OVERRIDE_YML
services:
 $(NGINX_NAME):
  
  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html
   - $(NGINX_VOLUMES_CONF):/etc/nginx/http.d

  ports:
  - "8888:8888"
   
endef

export NGINX_DOCKER_COMPOSE_OVERRIDE_YML