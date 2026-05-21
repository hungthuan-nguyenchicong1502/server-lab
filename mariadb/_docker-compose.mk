# mariadb/_docker-compose.mk

MARIADB_DOCKER_COMPOSE_YML_FILES := $(MARIADB_PROJECT_PATH)/docker-compose.yml

ifeq ($(APP_ENV), feature)
 MARIADB_DOCKER_COMPOSE_YML_FILES := $(MARIADB_PROJECT_PATH)/docker-compose.feature.yml
endif

_mariadb/_docker-compose.mk:
	@echo "_mariadb/_docker-compose.mk"
	make _mariadb/_docker-compose.mk-create-docker-compose-yml

_mariadb/_docker-compose.mk-create-docker-compose-yml:
	@echo "_mariadb/_docker-compose.mk-create-docker-compose-yml"
	printf "$$MARIADB_DOCKER_COMPOSE_YML" > $(MARIADB_PROJECT_PATH)/docker-compose.yml
	printf "$$MARIADB_DOCKER_COMPOSE_YML_FEATURE" > $(MARIADB_PROJECT_PATH)/docker-compose.feature.yml

_mariadb/_docker-compose.mk-build:
	@echo "_mariadb/_docker-compose.mk-build"
	docker compose -f $(MARIADB_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(MARIADB_PROJECT_PATH) \
		up -d --build

_mariadb/_docker-compose.mk-up:
	@echo "_mariadb/_docker-compose.mk-up"
	docker compose -f $(MARIADB_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(MARIADB_PROJECT_PATH) \
		up -d

_mariadb/_docker-compose.mk-down:
	@echo "_mariadb/_docker-compose.mk-down"
	docker compose -f $(MARIADB_DOCKER_COMPOSE_YML_FILES) \
		down

_mariadb/_docker-compose.mk-down-v:
	@echo "_mariadb/_docker-compose.mk-down-v"
	docker compose -f $(MARIADB_DOCKER_COMPOSE_YML_FILES) \
		up down -v