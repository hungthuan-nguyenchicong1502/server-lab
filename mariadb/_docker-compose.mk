# mariadb/_docker-compose.mk

_mariadb/_docker-compose.mk:
	@echo "_mariadb/_docker-compose.mk"
	$(MAKE) _mariadb/_docker-compose.mk-create-dockerfile
	$(MAKE) _mariadb/_docker-compose.mk-create-docker-compose-yml
	$(MAKE) _mariadb/_docker-compose.mk-build

_mariadb/_docker-compose.mk-create-dockerfile:
	@echo "_mariadb/_docker-compose.mk-create-dockerfile"
	printf "$$MARIADB_DOCKER_FILE" > $(MARIADB_PROJECT_PATH)/Dockerfile

_mariadb/_docker-compose.mk-create-docker-compose-yml:
	@echo "_mariadb/_docker-compose.mk-create-docker-compose-yml"
	printf "$$MARIADB_DOCKER_COMPOSE_YML" > $(MARIADB_PROJECT_PATH)/docker-compose.yml


_mariadb/_docker-compose.mk-build:
	@echo "_mariadb/_docker-compose.mk-build"
	docker compose -f $(MARIADB_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(MARIADB_PROJECT_PATH) \
		up -d --build

_mariadb/_docker-compose.mk-up:
	@echo "_mariadb/_docker-compose.mk-up"
	docker compose -f $(MARIADB_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(MARIADB_PROJECT_PATH) \
		up -d

_mariadb/_docker-compose.mk-down:
	@echo "_mariadb/_docker-compose.mk-down"
	docker compose -f $(MARIADB_PROJECT_PATH)/docker-compose.yml \
		down

_mariadb/_docker-compose.mk-down-v:
	@echo "_mariadb/_docker-compose.mk-down-v"
	docker compose -f $(MARIADB_PROJECT_PATH)/docker-compose.yml \
		up down -v