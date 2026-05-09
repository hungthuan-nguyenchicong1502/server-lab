# wp-app/_create-docker-compose-yml.mk

define WP_APP_DOCKER_COMPOSE_YML
services:
 $(WP_APP_NAME):
  image: $(WP_CLI_NAME)
  container_name: $(WP_APP_NAME)

  networks:
   - $(WP_APP_NAME)-net

  volumes:
   - $(WP_APP_VOLUMES_PROJECT_APP):/wp-app

networks:
 $(WP_APP_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export WP_APP_DOCKER_COMPOSE_YML

_wp-app/_create-docker-compose-yml.mk:
	@echo "_wp-app/_create-docker-compose-yml.mk"
	printf "$$WP_APP_DOCKER_COMPOSE_YML" > $(WP_APP_PROJECT_PATH)/docker-compose.yml