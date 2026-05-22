# nginx/_define-docker-compose-yml.mk

#main

define NGINX_DOCKER_COMPOSE_YML
services:
 $(NGINX_NAME_APP_ENV):
    
  image: $(NGINX_IMAGE)
  container_name: $(NGINX_NAME_APP_ENV)

  restart: always

  networks:
   - $(NGINX_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_NGINX_CONF):/etc/nginx/http.d
   - $(VOLUMES_PROJECT_APP):$(NGINX_WORKDIR)

networks:
 $(NGINX_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)

endef

export NGINX_DOCKER_COMPOSE_YML

# dev

define NGINX_DOCKER_COMPOSE_YML_DEV
services:
 $(NGINX_NAME_APP_ENV):
  
  build:
   context: .
   dockerfile: Dockerfile.dev

  image: $(NGINX_NAME_APP_ENV)
  container_name: $(NGINX_NAME_APP_ENV)

  restart: always

  ports:
   - "8080:8080"
   - "80:80"

  networks:
   - $(NGINX_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html
   - $(NGINX_VOLUMES_CONF):/etc/nginx/http.d

networks:
 $(NGINX_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export NGINX_DOCKER_COMPOSE_YML_DEV

# feature

define NGINX_DOCKER_COMPOSE_YML_FEATURE
services:
 $(NGINX_NAME_APP_ENV):
  
  image: $(NGINX_IMAGE)
  container_name: $(NGINX_NAME_APP_ENV)

#   user: "nginx:1000"

  restart: always

  ports:
   - "8080:8080"
   - "80:80"
   - "8888:8888"

  networks:
   - $(NGINX_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):$(NGINX_WORKDIR)
   - $(NGINX_VOLUMES_CONF):/etc/nginx/http.d

networks:
 $(NGINX_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export NGINX_DOCKER_COMPOSE_YML_FEATURE

# prod
define NGINX_DOCKER_COMPOSE_YML_PROD
services:
 $(NGINX_NAME_APP_ENV):
  
  build:
   context: .
   dockerfile: Dockerfile.prod

  image: $(NGINX_NAME_APP_ENV)
  container_name: $(NGINX_NAME_APP_ENV)

  restart: always

  ports:
   - "$(NGINX_PORT_WP_APP):$(NGINX_PORT_WP_APP)"
   - "$(NGINX_PORT_LARAVEL_APP):$(NGINX_PORT_LARAVEL_APP)"

  networks:
   - $(NGINX_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html
   - $(NGINX_VOLUMES_CONF):/etc/nginx/http.d

networks:
 $(NGINX_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export NGINX_DOCKER_COMPOSE_YML_PROD