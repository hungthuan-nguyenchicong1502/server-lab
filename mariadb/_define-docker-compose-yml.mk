# mariadb/_define-docker-compose-yml.mk

define MARIADB_DOCKER_COMPOSE_YML
services:
 $(MARIADB_NAME):
  build:
   context: .
   dockerfile: Dockerfile

  restart: always

  image: $(MARIADB_NAME)
  container_name: $(MARIADB_NAME)

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