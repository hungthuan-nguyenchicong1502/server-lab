# mariadb/_docker-compose.mk

_mariadb/_docker-compose.mk:
	@echo "_mariadb/_docker-compose.mk"
	$(MAKE) _mariadb/_docker-compose.mk-build


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
		up down

_mariadb/_docker-compose.mk-down-v:
	@echo "_mariadb/_docker-compose.mk-down-v"
	docker compose -f $(MARIADB_PROJECT_PATH)/docker-compose.yml \
		up down -v