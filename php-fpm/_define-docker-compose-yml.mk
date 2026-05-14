# php-fpm/_define-docker-compose-yml.mk

define PHP_FPM_DOCKER_COMPOSE_YML
services:
 $(PHP_FPM_NAME_APP_ENV):
  build:
   context: .
   dockerfile: Dockerfile
  
  image: $(PHP_FPM_NAME_APP_ENV)
  container_name: $(PHP_FPM_NAME_APP_ENV)

  restart: always

  networks:
   - $(PHP_FPM_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html

networks:
 $(PHP_FPM_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export PHP_FPM_DOCKER_COMPOSE_YML

define PHP_FPM_DOCKER_COMPOSE_DEV_YML
services:
 $(PHP_FPM_NAME_APP_ENV):
  build:
   context: .
   dockerfile: Dockerfile.dev
  
  image: $(PHP_FPM_NAME_APP_ENV)
  container_name: $(PHP_FPM_NAME_APP_ENV)

  restart: always

  networks:
   - $(PHP_FPM_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html

networks:
 $(PHP_FPM_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export PHP_FPM_DOCKER_COMPOSE_DEV_YML