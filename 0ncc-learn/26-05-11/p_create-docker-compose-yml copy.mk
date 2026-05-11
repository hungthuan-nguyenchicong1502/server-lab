# php-fpm/_create-docker-compose-yml.mk

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

networks:
 $(PHP_FPM_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export PHP_FPM_DOCKER_COMPOSE_YML

define PHP_FPM_DOCKER_COMPOSE_OVERRIDE_YML
services:
 $(PHP_FPM_NAME):
  volumes:
   - $(VOLUMES_PROJECT_APP):/var/www/html
endef

export PHP_FPM_DOCKER_COMPOSE_OVERRIDE_YML


_php-fpm/_create-docker-compose-yml.mk:
	@echo "_php-fpm/_create-docker-compose-yml.mk"
	printf "$$PHP_FPM_DOCKER_COMPOSE_YML" > $(PHP_FPM_PROJECT_PATH)/docker-compose.yml
	printf "$$PHP_FPM_DOCKER_COMPOSE_OVERRIDE_YML" > $(PHP_FPM_PROJECT_PATH)/docker-compose.override.yml