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
 $(LARAVEL_NAME)-dev:
#   build: !reset null

  build:
     context: .
     dockerfile: Dockerfile-dev

  image: $(LARAVEL_NAME)
  container_name: $(LARAVEL_NAME)-dev

#   ports:
#    - "8000:8000"
  
  volumes:
   - $(LARAVEL_VOLUMES_LARAVEL_APP):/laravel-app
   - laravel-dev-ssh_data:/root/.ssh

  networks:
     - $(LARAVEL_NAME)-net-dev
volumes:
 laravel-dev-ssh_data:

networks:
 $(LARAVEL_NAME)-net-dev:
  external: true
  name: $(MY_APP_NET)
endef

export LARAVEL_DOCKER_COMPOSE_DEV_YML