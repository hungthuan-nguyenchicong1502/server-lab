# php-fpm/_define-docker-compose-yml.mk

# main
define PHP_FPM_DOCKER_COMPOSE_YML
services:
 $(PHP_FPM_NAME_APP_ENV):
    
  image: $(PHP_FPM_IMAGE)
  container_name: $(PHP_FPM_NAME_APP_ENV)

  restart: always

  networks:
   - $(PHP_FPM_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):$(PHP_FPM_WORKDIR)

networks:
 $(PHP_FPM_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export PHP_FPM_DOCKER_COMPOSE_YML

#dev

define PHP_FPM_DOCKER_COMPOSE_YML_DEV
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

export PHP_FPM_DOCKER_COMPOSE_YML_DEV

#feature

define PHP_FPM_DOCKER_COMPOSE_YML_FEATURE
services:
 $(PHP_FPM_NAME_APP_ENV):
  build:
   context: .
   dockerfile: $(PHP_FPM_DOCKERFILE)
  
  image: $(PHP_FPM_IMAGE)
  container_name: $(PHP_FPM_NAME_APP_ENV)

  restart: always

  networks:
   - $(PHP_FPM_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_PROJECT_APP):$(PHP_FPM_WORKDIR)

networks:
 $(PHP_FPM_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export PHP_FPM_DOCKER_COMPOSE_YML_FEATURE

#prod

define PHP_FPM_DOCKER_COMPOSE_YML_PROD
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

export PHP_FPM_DOCKER_COMPOSE_YML_PROD