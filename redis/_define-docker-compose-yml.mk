# redis/_define-docker-compose-yml.mk

define REDIS_DOCKER_COMPOSE_YML
services:
 $(REDIS_NAME_APP_ENV):
  
  image: $(REDIS_IMAGE)
  container_name: $(REDIS_NAME_APP_ENV)

  restart: always

  networks:
   - $(REDIS_NAME_APP_ENV)-net

networks:
 $(REDIS_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef
export REDIS_DOCKER_COMPOSE_YML