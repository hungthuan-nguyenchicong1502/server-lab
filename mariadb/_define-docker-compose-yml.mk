# mariadb/_define-docker-compose-yml.mk

# main

define MARIADB_DOCKER_COMPOSE_YML
services:
 $(MARIADB_NAME_APP_ENV):
  
  restart: always

  image: $(MARIADB_IMAGE)
  container_name: $(MARIADB_NAME_APP_ENV)

  networks:
   - $(MARIADB_NAME_APP_ENV)-net

  volumes:
   - $(MARIADB_VOLUMES_DATA)/mariadb-data:/var/lib/mysql

networks:
 $(MARIADB_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export MARIADB_DOCKER_COMPOSE_YML

# feature 

define MARIADB_DOCKER_COMPOSE_YML_FEATURE
services:
 $(MARIADB_NAME_APP_ENV):
  
  restart: always

  image: $(MARIADB_IMAGE)
  container_name: $(MARIADB_NAME_APP_ENV)

  networks:
   - $(MARIADB_NAME_APP_ENV)-net

  volumes:
   - $(MARIADB_VOLUMES_DATA)/mariadb-data:/var/lib/mysql

networks:
 $(MARIADB_NAME_APP_ENV)-net:
  external: true
  name: $(MY_APP_NET)
endef

export MARIADB_DOCKER_COMPOSE_YML_FEATURE