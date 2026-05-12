# laravel/_define-docker-compose-yml.mk

define LARAVEL_DOCKER_COMPOSE_YML
services:
 $(LARAVEL_NAME):
  build:
   context: .
   dockerfile: Dockerfile
 
  image: $(LARAVEL_NAME)
  container_name: $(LARAVEL_NAME)

  networks:
   - $(LARAVEL_NAME)-net

  volumes:
   - $(LARAVEL_VOLUMES_LARAVEL_APP):/laravel-app

networks:
 $(LARAVEL_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export LARAVEL_DOCKER_COMPOSE_YML

define LARAVEL_DOCKER_COMPOSE_DEV_YML
services:
 $(LARAVEL_NAME):
  image: $(LARAVEL_NAME)
  container_name: $(LARAVEL_NAME)

  ports:
   - "8000:8000"
endef

export LARAVEL_DOCKER_COMPOSE_DEV_YML