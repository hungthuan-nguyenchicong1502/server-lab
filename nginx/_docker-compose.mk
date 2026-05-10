# nginx/_docker-compose.mk
NGINX_COMPOSE_FILES := -f $(NGINX_PROJECT_PATH)/docker-compose.yml

ifeq ($(APP_ENV), dev)
	NGINX_COMPOSE_FILES += -f $(NGINX_PROJECT_PATH)/docker-compose.override.yml
endif

_nginx/_docker-compose.mk:
	@echo "_nginx/_docker-compose.mk"
	$(MAKE) _nginx/_docker-compose.mk-build

_nginx/_docker-compose.mk-build:
	@echo "_nginx/_docker-compose.mk-build"
	docker compose $(NGINX_COMPOSE_FILES) \
		--project-directory $(NGINX_PROJECT_PATH) \
		up -d --build

_nginx/_docker-compose.mk-up:
	@echo "_nginx/_docker-compose.mk-up"
	docker compose $(NGINX_COMPOSE_FILES) \
		--project-directory $(NGINX_PROJECT_PATH) \
		up -d

_nginx/_docker-compose.mk-down:
	@echo "_nginx/_docker-compose.mk-down"
	docker compose $(NGINX_COMPOSE_FILES) \
		down

_nginx/_docker-compose.mk-down-v:
	@echo "_nginx/_docker-compose.mk-down-v"
	docker compose $(NGINX_COMPOSE_FILES) \
		down -v