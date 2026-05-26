# container-dev/_define-docker-compose-yml.mk

# main
define CONTAINER_DEV_DOCKER_COMPOSE_YML
services:
 $(CONTAINER_DEV_NAME_APP_ENV):
  
  image: $(CONTAINER_DEV_IMAGE)
  container_name: $(CONTAINER_DEV_NAME_APP_ENV)

  init: true

  restart: always

  networks:
   - $(CONTAINER_DEV_NAME_APP_ENV)-net

  ports:
   - "2222:22"

  env_file:
   - ./.env.container-dev
  
  volumes:
   # Volume doc lap cho .ssh
   - ssh_data_container_dev:/root/.ssh
   # Volumes dung chung up down -v
   - $(VOLUMES_CONTAINER_DEV_SSH):/tmp/root/.ssh:ro
   - $(VOLUMES_CONTAINER_DEV_VSCODE_SERVER):/root/.vscode-server
   - $(VOLUMES_CONTAINER_DEV_ROOT_GIT):/root/git

networks:
 $(CONTAINER_DEV_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)

volumes:
 ssh_data_container_dev:
 
endef
export CONTAINER_DEV_DOCKER_COMPOSE_YML

# feature
define CONTAINER_DEV_DOCKER_COMPOSE_YML_FEATURE
services:
 $(CONTAINER_DEV_NAME_APP_ENV):
  env_file:
   - ./.env.container-dev
  
  volumes:
#    - ./_makefile:/_makefile
   - $(VOLUMES_CONTAINER_DEV_SSH):/root/.ssh
   - $(VOLUMES_CONTAINER_DEV_VSCODE_SERVER):/root/.vscode-server
   - ./root/git:/root/git
endef
export CONTAINER_DEV_DOCKER_COMPOSE_YML_FEATURE