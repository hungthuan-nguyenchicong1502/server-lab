# nginx/_docker-compose.mk
NGINX_COMPOSE_FILES := -f $(NGINX_PROJECT_PATH)/docker-compose.$(APP_ENV).yml

_nginx/_docker-compose.mk:
	@echo "_nginx/_docker-compose.mk"
	$(MAKE) _nginx/_docker-compose.mk-create-dockerfile
	$(MAKE) _nginx/_docker-compose.mk-create-docker-compose-yml

_nginx/_docker-compose.mk-create-dockerfile:
	@echo "_nginx/_docker-compose.mk-create-dockerfile"
	printf "$$NGINX_DOCKERFILE_MAIN" > $(NGINX_PROJECT_PATH)/Dockerfile.main
	printf "$$NGINX_DOCKERFILE_DEV" > $(NGINX_PROJECT_PATH)/Dockerfile.dev
	printf "$$NGINX_DOCKERFILE_FEATURE" > $(NGINX_PROJECT_PATH)/Dockerfile.feature
	printf "$$NGINX_DOCKERFILE_PROD" > $(NGINX_PROJECT_PATH)/Dockerfile.prod



_nginx/_docker-compose.mk-create-docker-compose-yml:
	@echo "_nginx/_docker-compose.mk-create-docker-compose-yml"
	printf "$$NGINX_DOCKER_COMPOSE_YML_MAIN" > $(NGINX_PROJECT_PATH)/docker-compose.main.yml
	printf "$$NGINX_DOCKER_COMPOSE_YML_DEV" > $(NGINX_PROJECT_PATH)/docker-compose.dev.yml
	printf "$$NGINX_DOCKER_COMPOSE_YML_FEATURE" > $(NGINX_PROJECT_PATH)/docker-compose.feature.yml
	printf "$$NGINX_DOCKER_COMPOSE_YML_PROD" > $(NGINX_PROJECT_PATH)/docker-compose.prod.yml


_nginx/_docker-compose.mk-build:
	@echo "_nginx/_docker-compose.mk-build"
	docker compose $(NGINX_COMPOSE_FILES) \
		--project-directory $(NGINX_PROJECT_PATH) \
		--build --no-cache

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