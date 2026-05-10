# redis/_create-docker-compose-yml.mk

define REDIS_DOCKER_COMPOSE_YML
services:
 $(REDIS_NAME):
  build:
   context: .
   dockerfile: Dockerfile

  image: $(REDIS_NAME)
  container_name: $(REDIS_NAME)

  networks:
   - $(REDIS_NAME)-net

networks:
 $(REDIS_NAME)-net:
  external: true
  name: $(MY_APP_NET)

endef

export REDIS_DOCKER_COMPOSE_YML

_redis/_create-docker-compose-yml.mk:
	@echo "_redis/_create-docker-compose-yml.mk"
	printf "$$REDIS_DOCKER_COMPOSE_YML" > $(REDIS_PROJECT_PATH)/docker-compose.yml