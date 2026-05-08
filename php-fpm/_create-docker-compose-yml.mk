# php-fpm/_create-docker-compose-yml.mk

define PHP_FPM_DOCKER_COMPOSE_YML
services:
 $(PHP_FPM_NAME):
  build:
   context: .
   dockerfile: Dockerfile

  image: $(PHP_FPM_NAME)
  container_name: $(PHP_FPM_NAME)

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

_php-fpm/_create-docker-compose-yml.mk:
	@echo "_php-fpm/_create-docker-compose-yml.mk"
	printf "$$PHP_FPM_DOCKER_COMPOSE_YML" > $(PHP_FPM_PROJECT_PATH)/docker-compose.yml