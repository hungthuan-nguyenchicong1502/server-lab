# laravel/_define-docker-compose-yml.mk

# main
define LARAVEL_DOCKER_COMPOSE_YML
services:
 $(LARAVEL_NAME_APP_ENV):
  
  image: $(LARAVEL_IMAGE)
  container_name: $(LARAVEL_NAME_APP_ENV)

  networks:
   - $(LARAVEL_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_LARAVEL_APP):$(LARAVEL_WORKDIR)

networks:
 $(LARAVEL_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export LARAVEL_DOCKER_COMPOSE_YML

# dev
define LARAVEL_DOCKER_COMPOSE_YML_DEV
services:
 $(LARAVEL_NAME_APP_ENV):
  build:
     context: .
     dockerfile: $(LARAVEL_DOCKERFILE)

  image: $(LARAVEL_NAME_APP_ENV)
  container_name: $(LARAVEL_NAME_APP_ENV)

#   ports:
#    - "8000:8000"
  
  volumes:
   - $(LARAVEL_VOLUMES_LARAVEL_APP):/laravel-app
   - laravel-dev-ssh_data:/root/.ssh

  networks:
     - $(LARAVEL_NAME_APP_ENV)-net
volumes:
 laravel-dev-ssh_data:

networks:
 $(LARAVEL_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export LARAVEL_DOCKER_COMPOSE_YML_DEV

# feature

define LARAVEL_DOCKER_COMPOSE_YML_FEATURE
services:
 $(LARAVEL_NAME_APP_ENV):
  
  image: $(LARAVEL_IMAGE)
  container_name: $(LARAVEL_NAME_APP_ENV)

  volumes:
   - $(VOLUMES_LARAVEL_APP):$(LARAVEL_WORKDIR)

  networks:
     - $(LARAVEL_NAME_APP_ENV)-net

networks:
 $(LARAVEL_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export LARAVEL_DOCKER_COMPOSE_YML_FEATURE