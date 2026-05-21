# wp-cli/_docker-compose.mk

WP_CLI_DOCKER_COMPOSE_YML_FILES := $(WP_CLI_PROJECT_PATH)/docker-compose.$(APP_ENV).yml

_wp-cli/_docker-compose.mk:
	@echo "_wp-cli/_docker-compose.mk"
	make _wp-cli/_docker-compose.mk-create-docker-compose-yml

_wp-cli/_docker-compose.mk-create-docker-compose-yml:
	@echo "_wp-cli/_docker-compose.mk-create-docker-compose-yml"
	printf "$$WP_CLI_DOCKER_COMPOSE_YML" > $(WP_CLI_PROJECT_PATH)/docker-compose.yml
	printf "$$WP_CLI_DOCKER_COMPOSE_YML_FEATURE" > $(WP_CLI_PROJECT_PATH)/docker-compose.feature.yml

_wp-cli/_docker-compose.mk-build:
	@echo "_wp-cli/_docker-compose.mk-build"
	docker compose -f $(WP_CLI_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(WP_CLI_PROJECT_PATH) \
		build --no-cache

_wp-cli/_docker-compose.mk-up:
	@echo "_wp-cli/_docker-compose.mk-up"
	docker compose -f $(WP_CLI_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(WP_CLI_PROJECT_PATH) \
		up -d

_wp-cli/_docker-compose.mk-down:
	@echo "_wp-cli/_docker-compose.mk-down"
	docker compose -f $(WP_CLI_DOCKER_COMPOSE_YML_FILES) \
		down

_wp-cli/_docker-compose.mk-down-v:
	@echo "_wp-cli/_docker-compose.mk-down-v"
	docker compose -f $(WP_CLI_DOCKER_COMPOSE_YML_FILES) \
		down -v