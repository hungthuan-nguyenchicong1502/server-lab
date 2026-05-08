# nginx/_docker-compose.mk

_nginx/_docker-compose.mk:
	@echo "_nginx/_docker-compose.mk"
	$(MAKE) _nginx/_docker-compose.mk-build

_nginx/_docker-compose.mk-build:
	@echo "_nginx/_docker-compose.mk-build"
	docker compose -f $(NGINX_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(NGINX_PROJECT_PATH) \
		up -d --build

_nginx/_docker-compose.mk-up:
	@echo "_nginx/_docker-compose.mk-up"
	docker compose -f $(NGINX_PROJECT_PATH)/docker-compose.yml \
		--project-directory $(NGINX_PROJECT_PATH) \
		up -d

_nginx/_docker-compose.mk-down:
	@echo "_nginx/_docker-compose.mk-down"
	docker compose -f $(NGINX_PROJECT_PATH)/docker-compose.yml \
		down

_nginx/_docker-compose.mk-down-v:
	@echo "_nginx/_docker-compose.mk-down-v"
	docker compose -f $(NGINX_PROJECT_PATH)/docker-compose.yml \
		down -v