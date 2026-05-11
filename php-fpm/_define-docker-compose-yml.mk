# php-fpm/_define-docker-compose-yml.mk

define PHP_FPM_DOCKER_COMPOSE_YML
services:
 $(PHP_FPM_NAME):
  build:
   context: .
   dockerfile: Dockerfile
  
  image: $(PHP_FPM_NAME)
  container_name: $(PHP_FPM_NAME)

  restart: always

  networks:
   - $(PHP_FPM_NAME)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html

networks:
 $(PHP_FPM_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export PHP_FPM_DOCKER_COMPOSE_YML

define PHP_FPM_DOCKER_COMPOSE_OVERRIDE_YML
services:
 $(PHP_FPM_NAME):
  build:
   context: .
   dockerfile: Dockerfile-$(APP_ENV)

  image: $(PHP_FPM_NAME)-$(APP_ENV)
  container_name: $(PHP_FPM_NAME)-$(APP_ENV)

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html
endef

export PHP_FPM_DOCKER_COMPOSE_OVERRIDE_YML