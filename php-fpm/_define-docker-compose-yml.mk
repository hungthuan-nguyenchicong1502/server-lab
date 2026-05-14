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

define PHP_FPM_DOCKER_COMPOSE_DEV_YML
services:
 $(PHP_FPM_NAME)-dev:
  build:
   context: .
   dockerfile: Dockerfile-dev
  
  image: $(PHP_FPM_NAME)-dev
  container_name: $(PHP_FPM_NAME)-dev

  restart: always

  networks:
   - $(PHP_FPM_NAME)-net-dev

  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html

networks:
 $(PHP_FPM_NAME)-net-dev:
  external: true
  name: $(MY_APP_NET)
endef

export PHP_FPM_DOCKER_COMPOSE_DEV_YML