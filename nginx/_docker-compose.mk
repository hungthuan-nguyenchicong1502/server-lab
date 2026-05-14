# nginx/_docker-compose.mk
NGINX_COMPOSE_FILES := -f $(NGINX_PROJECT_PATH)/docker-compose.yml

ifeq ($(APP_ENV), dev)
	NGINX_COMPOSE_FILES += -f $(NGINX_PROJECT_PATH)/docker-compose.dev.yml
endif

_nginx/_docker-compose.mk:
	@echo "_nginx/_docker-compose.mk"
	$(MAKE) _nginx/_docker-compose.mk-create-dockerfile
	$(MAKE) _nginx/_docker-compose.mk-create-docker-compose-yml
	$(MAKE) _nginx/_docker-compose.mk-build


_nginx/_docker-compose.mk-create-dockerfile:
	@echo "_nginx/_docker-compose.mk-create-dockerfile"
	printf "$$NGINX_DOCKERFILE" > $(NGINX_PROJECT_PATH)/Dockerfile
	printf "$$NGINX_DOCKERFILE_DEV" > $(NGINX_PROJECT_PATH)/Dockerfile.dev


_nginx/_docker-compose.mk-create-docker-compose-yml:
	@echo "_nginx/_docker-compose.mk-create-docker-compose-yml"
	printf "$$NGINX_DOCKER_COMPOSE_YML" > $(NGINX_PROJECT_PATH)/docker-compose.yml
	printf "$$NGINX_DOCKER_COMPOSE_DEV_YML" > $(NGINX_PROJECT_PATH)/docker-compose.dev.yml


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