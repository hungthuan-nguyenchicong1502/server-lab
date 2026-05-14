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

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html
   - $(NGINX_VOLUMES_CONF):/etc/nginx/http.d

networks:
 $(NGINX_NAME)-net:
  external: true
  name: $(MY_APP_NET)

endef

export NGINX_DOCKER_COMPOSE_YML

# override
define NGINX_DOCKER_COMPOSE_DEV_YML
services:
 $(NGINX_NAME)-dev:
    
  image: $(NGINX_NAME)
  container_name: $(NGINX_NAME)-dev

  restart: always

  ports:
   - "8080:8080"
   - "8888:8888"

  networks:
   - $(NGINX_NAME)-net-dev

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html
   - $(NGINX_VOLUMES_CONF):/etc/nginx/http.d

networks:
 $(NGINX_NAME)-net-dev:
  external: true
  name: $(MY_APP_NET)
endef

export NGINX_DOCKER_COMPOSE_DEV_YML