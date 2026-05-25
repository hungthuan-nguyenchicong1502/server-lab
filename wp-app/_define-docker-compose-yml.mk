# wp-app/_define-docker-compose-yml.mk

# main

define WP_APP_DOCKER_COMPOSE_YML
services:
 $(WP_APP_NAME_APP_ENV):
  
  image: $(WP_APP_IMAGE)
  container_name: $(WP_APP_NAME_APP_ENV)

  networks:
   - $(WP_APP_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_WP_APP):$(WP_PATH)

networks:
 $(WP_APP_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export WP_APP_DOCKER_COMPOSE_YML

# feature
define WP_APP_DOCKER_COMPOSE_YML_FEATURE
services:
 $(WP_APP_NAME_APP_ENV):
  
  image: $(WP_APP_IMAGE)
  container_name: $(WP_APP_NAME_APP_ENV)

  networks:
   - $(WP_APP_NAME_APP_ENV)-net

  volumes:
   - $(VOLUMES_WP_APP):$(WP_PATH)

networks:
 $(WP_APP_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export WP_APP_DOCKER_COMPOSE_YML_FEATURE