# laravel-octane/_define-docker-compose-yml.mk

# main 
# define LARAVEL_OCTANE_DOCKER_COMPOSE_YML
# services:
#  $(LARAVEL_OCTANE_NAME_APP_ENV):
#   build:
#    context: .
#    dockerfile: Dockerfile
   
#   restart: always

#   image: $(LARAVEL_OCTANE_NAME_APP_ENV)
#   container_name: $(LARAVEL_OCTANE_NAME_APP_ENV)
  
#   networks:
#    - $(LARAVEL_OCTANE_NAME_APP_ENV)-net
#    - internal-bridge-laravel-octane

#   volumes:
#    - $(VOLUMES_LARAVEL_APP):/laravel-app

# #   ports:
# #    - "1000:1000"

#   environment:
#    - OCTANE_SERVER=swoole
 
#  $(LARAVEL_OCTANE_NAME_REDIS_APP_ENV):
#   image: $(REDIS_NAME)
#   container_name: $(LARAVEL_OCTANE_NAME_REDIS_APP_ENV)

#   networks:
#    - internal-bridge-laravel-octane

# networks:
#  $(LARAVEL_OCTANE_NAME_APP_ENV)-net:
#   external: true
#   name: $(MY_APP_NET)

#  internal-bridge-laravel-octane:
#   driver: bridge
#   internal: true
# endef

# export LARAVEL_OCTANE_DOCKER_COMPOSE_YML

# feature
define LARAVEL_OCTANE_DOCKER_COMPOSE_YML_FEATURE
services:
 $(LARAVEL_OCTANE_NAME_APP_ENV):
  build:
   context: .
   dockerfile: Dockerfile.feature
   
  restart: always

  image: $(LARAVEL_OCTANE_NAME_APP_ENV)
  container_name: $(LARAVEL_OCTANE_NAME_APP_ENV)
  
  networks:
   - $(LARAVEL_OCTANE_NAME_APP_ENV)-net
   - internal-bridge-laravel-octane-feature

  user: "root:root"

  volumes:
   - $(VOLUMES_LARAVEL_APP)/$(APP_ENV):$(LARAVEL_WORKDIR_APP_ENV)

#   ports:
#    - "1000:1000"

  environment:
   - OCTANE_SERVER=swoole
 
 $(LARAVEL_OCTANE_NAME_REDIS_APP_ENV):
  image: $(REDIS_NAME)
  container_name: $(LARAVEL_OCTANE_NAME_REDIS_APP_ENV)

  networks:
   - internal-bridge-laravel-octane-feature

networks:
 $(LARAVEL_OCTANE_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)

 internal-bridge-laravel-octane-feature:
  driver: bridge
  internal: true
endef

export LARAVEL_OCTANE_DOCKER_COMPOSE_YML_FEATURE