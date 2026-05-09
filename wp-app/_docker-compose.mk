# wp-app/_docker-compose.mk

_wp-app/_docker-compose.mk:
	@echo "_wp-app/_docker-compose.mk"
	$(MAKE) _wp-app/_docker-compose.mk-up


_wp-app/_docker-compose.mk-up:
	@echo "_wp-app/_docker-compose.mk-up"
	docker compose -f $(WP_APP_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(WP_APP_PROJECT_PATH) \
		up -d

_wp-app/_docker-compose.mk-down:
	@echo "_wp-app/_docker-compose.mk-down"
	docker compose -f $(WP_APP_PROJECT_PATH)/docker-compose.yml \
		down

_wp-app/_docker-compose.mk-down-v:
	@echo "_wp-app/_docker-compose.mk-down-v"
	docker compose -f $(WP_APP_PROJECT_PATH)/docker-compose.yml \
		down -v