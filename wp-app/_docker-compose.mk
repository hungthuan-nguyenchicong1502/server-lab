# wp-app/_docker-compose.mk

WP_APP_COMPOSE_FILES := -f $(WP_APP_PROJECT_PATH)/docker-compose.yml

ifeq ($(APP_ENV), dev)
	WP_APP_COMPOSE_FILES += -f $(WP_APP_PROJECT_PATH)/docker-compose.override.yml
endif

_wp-app/_docker-compose.mk:
	@echo "_wp-app/_docker-compose.mk"
	$(MAKE) _wp-app/_docker-compose.mk-up

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