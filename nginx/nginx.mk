# nginx/nginx.mk
NGINX_NAME = nginx-alpine-ncc
NGINX_PROJECT_PATH = $(PROJECT_PATH)/nginx
# use $(NGINX_VOLUMES_CONF):/etc/nginx/http.d
NGINX_VOLUMES_CONF = $(VOLUMES_PROJECT)/nginx-conf

# include
include nginx/_define_docker-file.mk
include nginx/_define-docker-compose-yml.mk
include nginx/_docker-compose.mk

# test
include nginx/nginx-test/nginx-test.mk

_nginx-prepare:
	@echo "_nginx-prepare"
	mkdir -p $(NGINX_PROJECT_PATH)
	mkdir -p $(NGINX_VOLUMES_CONF)

nginx-setup: _nginx-prepare
	@echo "nginx-setup"
	$(MAKE) _nginx/_docker-compose.mk

nginx-up:
	@echo "nginx-up"
	$(MAKE) _nginx/_docker-compose.mk-up

nginx-down:
	@echo "nginx-down"
	$(MAKE) _nginx/_docker-compose.mk-down

nginx-down-v:
	@echo "nginx-down-v"
	$(MAKE) _nginx/_docker-compose.mk-down-v

nginx-conf-ls:
	ls $(NGINX_VOLUMES_CONF)

nginx-reload:
	docker exec $(NGINX_NAME) nginx -s reload