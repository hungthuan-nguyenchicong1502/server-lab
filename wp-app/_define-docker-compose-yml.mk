# wp-app/_define-docker-compose-yml.mk

define WP_APP_DOCKER_COMPOSE_YML
services:
 $(WP_APP_NAME):

  image: $(WP_CLI_NAME)
  container_name: $(WP_APP_NAME)

  networks:
   - $(WP_APP_NAME)-net

  volumes:
   - $(WP_APP_VOLUMES_PROJECT_APP):/$(WP_PATH)

networks:
 $(WP_APP_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export WP_APP_DOCKER_COMPOSE_YML

define WP_APP_DOCKER_COMPOSE_OVERRIDE_YML
services:
 $(WP_APP_NAME):
  volumes:
   - $(WP_APP_VOLUMES_PROJECT_APP):/wp-app
endef

export WP_APP_DOCKER_COMPOSE_OVERRIDE_YML