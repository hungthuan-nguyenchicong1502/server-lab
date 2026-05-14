# nginx/_define-docker-compose-yml.mk

define NGINX_DOCKER_COMPOSE_YML
services:
 $(NGINX_NAME_APP_NAME):
  build:
   context: .
   dockerfile: Dockerfile
  
  image: $(NGINX_NAME_APP_NAME)
  container_name: $(NGINX_NAME_APP_NAME)

  restart: always

  networks:
   - $(NGINX_NAME_APP_NAME)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html
   - $(NGINX_VOLUMES_CONF):/etc/nginx/http.d

networks:
 $(NGINX_NAME_APP_NAME)-net:
  external: true
  name: $(MY_APP_NET)

endef

export NGINX_DOCKER_COMPOSE_YML

# override
define NGINX_DOCKER_COMPOSE_DEV_YML
services:
 $(NGINX_NAME_APP_NAME):
  
  build:
   context: .
   dockerfile: Dockerfile.dev

  image: $(NGINX_NAME_APP_NAME)
  container_name: $(NGINX_NAME_APP_NAME)

  restart: always

  ports:
   - "8080:8080"
   - "80:80"

  networks:
   - $(NGINX_NAME_APP_NAME)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html
   - $(NGINX_VOLUMES_CONF):/etc/nginx/http.d

networks:
 $(NGINX_NAME_APP_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export NGINX_DOCKER_COMPOSE_DEV_YML