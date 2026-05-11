# wp-cli/_define-docker-compose-yml.mk

define WP_CLI_DOCKER_COMPOSE_YML
services:
 $(WP_CLI_NAME):
  build:
   context: .
   dockerfile: Dockerfile

  image: $(WP_CLI_NAME)
  container_name: $(WP_CLI_NAME)

  networks:
   - $(WP_CLI_NAME)-net

networks:
 $(WP_CLI_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export WP_CLI_DOCKER_COMPOSE_YML