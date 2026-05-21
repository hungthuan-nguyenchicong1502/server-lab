# wp-cli/_define-docker-compose-yml.mk

# main
define WP_CLI_DOCKER_COMPOSE_YML
services:
 $(WP_CLI_NAME_APP_ENV):
  
  image: $(WP_CLI_IMAGE)
  container_name: $(WP_CLI_NAME_APP_ENV)

  networks:
   - $(WP_CLI_NAME_APP_ENV)-net

networks:
 $(WP_CLI_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export WP_CLI_DOCKER_COMPOSE_YML

# feature
define WP_CLI_DOCKER_COMPOSE_YML_FEATURE
services:
 $(WP_CLI_NAME_APP_ENV):
  build:
   context: .
   dockerfile: $(WP_CLI_DOCKERFILE)

  image: $(WP_CLI_IMAGE)
  container_name: $(WP_CLI_NAME_APP_ENV)

  networks:
   - $(WP_CLI_NAME_APP_ENV)-net

networks:
 $(WP_CLI_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export WP_CLI_DOCKER_COMPOSE_YML_FEATURE