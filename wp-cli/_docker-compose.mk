# wp-cli/_docker-compose.mk

WP_CLI_COMPOSE_FILES := -f $(WP_CLI_PROJECT_PATH)/docker-compose.$(APP_ENV).yml

_wp-cli/_docker-compose.mk:
	@echo "_wp-cli/_docker-compose.mk"
	$(MAKE) _wp-cli/_docker-compose.mk-create-dockerfile
	$(MAKE) _wp-cli/_docker-compose.mk-create-docker-compose-yml

_wp-cli/_docker-compose.mk-create-dockerfile:
	@echo "_wp-cli/_docker-compose.mk-create-dockerfile"
	printf "$$WP_CLI_DOCKER_FILE_MAIN" > $(WP_CLI_PROJECT_PATH)/Dockerfile.main
	printf "$$WP_CLI_DOCKER_FILE_FEATURE" > $(WP_CLI_PROJECT_PATH)/Dockerfile.feature

_wp-cli/_docker-compose.mk-create-docker-compose-yml:
	@echo "_wp-cli/_docker-compose.mk-create-docker-compose-yml"
	printf "$$WP_CLI_DOCKER_COMPOSE_YML_MAIN" > $(WP_CLI_PROJECT_PATH)/docker-compose.main.yml
	printf "$$WP_CLI_DOCKER_COMPOSE_YML_FEATURE" > $(WP_CLI_PROJECT_PATH)/docker-compose.feature.yml

_wp-cli/_docker-compose.mk-build:
	@echo "_wp-cli/_docker-compose.mk-build"
	docker compose $(WP_CLI_COMPOSE_FILES) \
		--project-directory $(WP_CLI_PROJECT_PATH) \
		build --no-cache

_wp-cli/_docker-compose.mk-up:
	@echo "_wp-cli/_docker-compose.mk-up"
	docker compose $(WP_CLI_COMPOSE_FILES) \
		--project-directory $(WP_CLI_PROJECT_PATH) \
		up -d

_wp-cli/_docker-compose.mk-down:
	@echo "_wp-cli/_docker-compose.mk-down"
	docker compose $(WP_CLI_COMPOSE_FILES) \
		down

_wp-cli/_docker-compose.mk-down-v:
	@echo "_wp-cli/_docker-compose.mk-down-v"
	docker compose $(WP_CLI_COMPOSE_FILES) \
		down -v