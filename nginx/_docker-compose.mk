# nginx/_docker-compose.mk
NGINX_DOCKER_COMPOSE_YML_FILES := $(NGINX_PROJECT_PATH)/docker-compose.yml

ifeq ($(APP_ENV), feature)
 NGINX_DOCKER_COMPOSE_YML_FILES := $(NGINX_PROJECT_PATH)/docker-compose.feature.yml
endif

ifeq ($(APP_ENV), prod)
 NGINX_DOCKER_COMPOSE_YML_FILES := $(NGINX_PROJECT_PATH)/docker-compose.prod.yml
endif

_nginx/_docker-compose.mk:
	@echo "_nginx/_docker-compose.mk"
	make _nginx/_docker-compose.mk-create-docker-compose-yml


_nginx/_docker-compose.mk-create-docker-compose-yml:
	@echo "_nginx/_docker-compose.mk-create-docker-compose-yml"
	printf "$$NGINX_DOCKER_COMPOSE_YML" > $(NGINX_PROJECT_PATH)/docker-compose.yml
	printf "$$NGINX_DOCKER_COMPOSE_YML_DEV" > $(NGINX_PROJECT_PATH)/docker-compose.dev.yml
	printf "$$NGINX_DOCKER_COMPOSE_YML_FEATURE" > $(NGINX_PROJECT_PATH)/docker-compose.feature.yml
	printf "$$NGINX_DOCKER_COMPOSE_YML_PROD" > $(NGINX_PROJECT_PATH)/docker-compose.prod.yml


_nginx/_docker-compose.mk-build:
	@echo "_nginx/_docker-compose.mk-build"
	docker compose -f $(NGINX_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(NGINX_PROJECT_PATH) \
		--build --no-cache

_nginx/_docker-compose.mk-up:
	@echo "_nginx/_docker-compose.mk-up"
	docker compose -f $(NGINX_DOCKER_COMPOSE_YML_FILES) \
		--project-directory $(NGINX_PROJECT_PATH) \
		up -d

_nginx/_docker-compose.mk-down:
	@echo "_nginx/_docker-compose.mk-down"
	docker compose -f $(NGINX_DOCKER_COMPOSE_YML_FILES) \
		down

_nginx/_docker-compose.mk-down-v:
	@echo "_nginx/_docker-compose.mk-down-v"
	docker compose -f $(NGINX_DOCKER_COMPOSE_YML_FILES) \
		down -v