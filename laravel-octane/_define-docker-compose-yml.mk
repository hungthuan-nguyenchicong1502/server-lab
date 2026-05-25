# laravel-octane/_define-docker-compose-yml.mk

# main 
define LARAVEL_OCTANE_DOCKER_COMPOSE_YML
services:
 $(LARAVEL_OCTANE_NAME_APP_ENV):

  image: $(LARAVEL_OCTANE_IMAGE)
  container_name: $(LARAVEL_OCTANE_NAME_APP_ENV)
  
  restart: always

  networks:
   - $(LARAVEL_OCTANE_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_LARAVEL_APP):$(LARAVEL_OCTANE_WORKDIR)

  environment:
   - OCTANE_SERVER=swoole
 
networks:
 $(LARAVEL_OCTANE_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)

endef

export LARAVEL_OCTANE_DOCKER_COMPOSE_YML

# feature
define LARAVEL_OCTANE_DOCKER_COMPOSE_YML_FEATURE
services:
 $(LARAVEL_OCTANE_NAME_APP_ENV):

  image: $(LARAVEL_OCTANE_IMAGE)
  container_name: $(LARAVEL_OCTANE_NAME_APP_ENV)
  
  restart: always
  
  networks:
   - $(LARAVEL_OCTANE_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_LARAVEL_APP):$(LARAVEL_OCTANE_WORKDIR)
   - $(VOLUMES_CONTAINER_GIT_CLONE):$(CONTAINER_GIT_CLONE_WORKDIR)
  ports:
   - "1000:1000"

  environment:
   - OCTANE_SERVER=swoole
 
networks:
 $(LARAVEL_OCTANE_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)

endef

export LARAVEL_OCTANE_DOCKER_COMPOSE_YML_FEATURE