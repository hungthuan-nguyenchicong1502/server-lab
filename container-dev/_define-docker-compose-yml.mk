# container-dev/_define-docker-compose-yml.mk

define CONTAINER_DEV_DOCKER_COMPOSE_YML
services:
 $(CONTAINER_DEV_NAME_APP_ENV):
  
  image: $(CONTAINER_DEV_IMAGE)
  container_name: $(CONTAINER_DEV_NAME_APP_ENV)

  restart: always

  networks:
   - $(CONTAINER_DEV_NAME_APP_ENV)-net

  ports:
   - "2222:22"

networks:
 $(CONTAINER_DEV_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef
export CONTAINER_DEV_DOCKER_COMPOSE_YML