docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d

docker-compose.override.yml

# Trong Makefile
COMPOSE_FILES := -f $(NGINX_PROJECT_PATH)/docker-compose.yml

# Kiểm tra nếu đang ở môi trường dev thì cộng thêm file override
ifeq ($(APP_ENV), dev)
    COMPOSE_FILES += -f $(NGINX_PROJECT_PATH)/docker-compose.override.yml
endif

_nginx-up:
	docker compose $(COMPOSE_FILES) --project-directory $(NGINX_PROJECT_PATH) up -d --build