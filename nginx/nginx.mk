# nginx/nginx.mk
NGINX_NAME = nginx-alpine-ncc
NGINX_PROJECT_PATH = $(PROJECT_PATH)/nginx
# use $(NGINX_VOLUMES_CONF):/etc/nginx/http.d
NGINX_VOLUMES_CONF = $(VOLUMES_PROJECT)/nginx-conf

# include
include nginx/_create-dockerfile.mk
include nginx/_create-docker-compose-yml.mk
include nginx/_docker-compose.mk

# test
include nginx/nginx-test/nginx-test.mk

_nginx-prepare:
	@echo "_nginx-prepare"
	mkdir -p $(NGINX_PROJECT_PATH)
	mkdir -p $(NGINX_VOLUMES_CONF)

nginx-setup: _nginx-prepare
	@echo "nginx-setup"
	$(MAKE) _nginx/_create-dockerfile.mk
	$(MAKE) _nginx/_create-docker-compose-yml.mk
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