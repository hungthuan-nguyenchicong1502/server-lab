# mariadb/_create-docker-compose-yml.mk

define MARIADB_DOCKER_COMPOSE_YML
services:
 $(MARIADB_NAME):
  build:
   context: .
   dockerfile: Dockerfile

  image: $(MARIADB_NAME)
  container_name: $(MARIADB_NAME)
  restart: unless-stopped

  networks:
   - $(MARIADB_NAME)-net

  volumes:
   - $(VOLUMES_PROJECT)/mariadb-data:/var/lib/mysql

networks:
 $(MARIADB_NAME)-net:
  external: true
  name: $(MY_APP_NET)
endef

export MARIADB_DOCKER_COMPOSE_YML

_mariadb/_create-docker-compose-yml.mk:
	@echo "_mariadb/_create-docker-compose-yml.mk"
	printf "$$MARIADB_DOCKER_COMPOSE_YML" > $(MARIADB_PROJECT_PATH)/docker-compose.yml