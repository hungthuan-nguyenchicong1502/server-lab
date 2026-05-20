# wp-app/_define-docker-compose-yml.mk

# main

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

# feature


define WP_APP_DOCKER_COMPOSE_YML_FEATURE
services:
 $(WP_APP_NAME):

  image: $(WP_CLI_NAME)
  container_name: $(WP_APP_NAME)

#   user: "root:1000"

  networks:
   - $(WP_APP_NAME)-net

  volumes:
   - $(WP_APP_VOLUMES_PROJECT_APP):/$(WP_PATH)

networks:
 $(WP_APP_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export WP_APP_DOCKER_COMPOSE_YML_FEATURE