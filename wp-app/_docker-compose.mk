# wp-app/_docker-compose.mk

WP_APP_COMPOSE_FILES := -f $(WP_APP_PROJECT_PATH)/docker-compose.$(APP_ENV).yml

_wp-app/_docker-compose.mk:
	@echo "_wp-app/_docker-compose.mk"
	make _wp-app/_docker-compose.mk-create-docker-file
	make _wp-app/_docker-compose.mk-create-docker-compose-yml

_wp-app/_docker-compose.mk-create-docker-file:
	@echo "_wp-app/_docker-compose.mk-create-docker-file"
	printf "$$WP_APP_DOCKER_FILE_MAIN" > $(WP_APP_PROJECT_PATH)/Dockerfile.main
	printf "$$WP_APP_DOCKER_FILE_FEATURE" > $(WP_APP_PROJECT_PATH)/Dockerfile.feature

_wp-app/_docker-compose.mk-create-docker-compose-yml:
	@echo "_wp-app/_docker-compose.mk-create-docker-compose-yml"
	printf "$$WP_APP_DOCKER_COMPOSE_YML" > $(WP_APP_PROJECT_PATH)/docker-compose.yml
	printf "$$WP_APP_DOCKER_COMPOSE_YML_FEATURE" > $(WP_APP_PROJECT_PATH)/docker-compose.feature.yml

_wp-app/_docker-compose.mk-build:
	@echo "_wp-app/_docker-compose.mk-up"
	docker compose $(WP_APP_COMPOSE_FILES) \
		--project-directory $(WP_APP_PROJECT_PATH) \
		build --no-cache

_wp-app/_docker-compose.mk-up:
	@echo "_wp-app/_docker-compose.mk-up"
	docker compose $(WP_APP_COMPOSE_FILES) \
		--project-directory $(WP_APP_PROJECT_PATH) \
		up -d

_wp-app/_docker-compose.mk-down:
	@echo "_wp-app/_docker-compose.mk-down"
	docker compose $(WP_APP_COMPOSE_FILES) \
		down

_wp-app/_docker-compose.mk-down-v:
	@echo "_wp-app/_docker-compose.mk-down-v"
	docker compose $(WP_APP_COMPOSE_FILES) \
		down -v