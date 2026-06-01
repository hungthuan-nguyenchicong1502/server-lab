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
   - $(VOLUMES_PROJECT_APP_PATH):$(NGINX_WORKDIR)

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
   - $(VOLUMES_PROJECT_APP_PATH):/var/www/html
   - $(VOLUMES_NGINX_CONF):/etc/nginx/http.d

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

  restart: always

  ports:
   - "8080:8080"
   - "80:80"
   - "8888:8888"

  networks:
   - $(NGINX_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_NGINX_CONF):/etc/nginx/http.d
   - $(VOLUMES_PROJECT_APP_PATH):$(NGINX_WORKDIR)

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
  
  image: $(NGINX_IMAGE)
  container_name: $(NGINX_NAME_APP_ENV)

  restart: always
  
  networks:
   - $(NGINX_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_NGINX_CONF):/etc/nginx/http.d
   - $(VOLUMES_PROJECT_APP_PATH):$(NGINX_WORKDIR)

  ports:
   - "80:80"
   - "8080:8080"

networks:
 $(NGINX_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export NGINX_DOCKER_COMPOSE_YML_PROD