# container-git-clone/_defile-docker-compose-yml.mk

define CONTAINER_GIT_CLONE_DOCKER_COMPOSE_YML
services:
 $(CONTAINER_GIT_CLONE_NAME_APP_ENV):
  
  image: $(CONTAINER_GIT_CLONE_IMAGE)
  container_name: $(CONTAINER_GIT_CLONE_NAME_APP_ENV)

  networks:
   - $(CONTAINER_GIT_CLONE_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_CONTAINER_DEV_SSH):/root/.ssh
   - $(VOLUMES_LARAVEL_APP):$(LARAVEL_WORKDIR)
   - $(CONTAINER_GIT_CLONE_PROFILE_SH_TARGET):/etc/profile.d/container-git-clone-profile.sh

networks:
 $(CONTAINER_GIT_CLONE_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef
export CONTAINER_GIT_CLONE_DOCKER_COMPOSE_YML