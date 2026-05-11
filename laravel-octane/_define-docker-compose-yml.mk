# laravel-octane/_define-docker-compose-yml.mk
define LARAVEL_OCTANE_DOCKER_COMPOSE_YML
services:
 $(LARAVEL_OCTANE_NAME):
  build:
   context: .
   dockerfile: Dockerfile

  image: $(LARAVEL_OCTANE_NAME)
  container_name: $(LARAVEL_OCTANE_NAME)
  
  networks:
   - $(LARAVEL_OCTANE_NAME)-net
   - internal-bridge-laravel-octane

  volumes:
   - $(LARAVEL_VOLUMES_LARAVEL_APP):/laravel-app

  ports:
   - "1000:1000"

  environment:
   - OCTANE_SERVER=swoole
 
 $(LARAVEL_OCTANE_REDIS_NAME):
  image: $(REDIS_NAME)
  container_name: $(LARAVEL_OCTANE_REDIS_NAME)

  networks:
   - internal-bridge-laravel-octane

networks:
 $(LARAVEL_OCTANE_NAME)-net:
  external: true
  name: $(MY_APP_NET)

 internal-bridge-laravel-octane:
  driver: bridge
  internal: true
endef

export LARAVEL_OCTANE_DOCKER_COMPOSE_YML