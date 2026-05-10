# laravel/_create-docker-compose-yml.mk

define LARAVEL_DOCKER_COMPOSE_YML
services:
 $(LARAVEL_NAME):
  build:
   context: .
   dockerfile: Dockerfile
 
  image: $(LARAVEL_NAME)
  container_name: $(LARAVEL_NAME)

  networks:
   - $(LARAVEL_NAME)-net

  volumes:
   - $(LARAVEL_VOLUMES_LARAVEL_APP):/laravel-app

  ports:
   - "8000:8000"

networks:
 $(LARAVEL_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export LARAVEL_DOCKER_COMPOSE_YML

_laravel/_create-docker-compose-yml.mk:
	@echo "_laravel/_create-docker-compose-yml.mk"
	printf "$$LARAVEL_DOCKER_COMPOSE_YML" > $(LARAVEL_PROJECT_PATH)/docker-compose.yml