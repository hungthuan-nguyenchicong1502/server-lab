# wp-cli/_docker-compose.mk

_wp-cli/_docker-compose.mk:
	@echo "_wp-cli/_docker-compose.mk"
	$(MAKE) _wp-cli/_docker-compose.mk-build

_wp-cli/_docker-compose.mk-build:
	@echo "_wp-cli/_docker-compose.mk-build"
	docker compose -f $(WP_CLI_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(WP_CLI_PROJECT_PATH) \
		build

_wp-cli/_docker-compose.mk-up:
	@echo "_wp-cli/_docker-compose.mk-up"
	docker compose -f $(WP_CLI_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(WP_CLI_PROJECT_PATH) \
		up -d

_wp-cli/_docker-compose.mk-down:
	@echo "_wp-cli/_docker-compose.mk-down"
	docker compose -f $(WP_CLI_PROJECT_PATH)/docker-compose.yml \
		down

_wp-cli/_docker-compose.mk-down-v:
	@echo "_wp-cli/_docker-compose.mk-down-v"
	docker compose -f $(WP_CLI_PROJECT_PATH)/docker-compose.yml \
		down -v