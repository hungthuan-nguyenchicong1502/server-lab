# nginx/nginx-test/nginx-test.mk
NGINX_TEST_VOLUMES = $(VOLUMES_PROJECT_APP)/nginx-test
NGINX_TEST_PROJECT_PATH = $(NGINX_PROJECT_PATH)/nginx-test
NGINX_TEXT_PATH = ./nginx/nginx-test

include nginx/nginx-test/_define-nginx-test-conf.mk

_nginx-test-prepre:
	@echo "_nginx-test-prepre"
	$(MAKE) _nginx-test-create-nginx-test-conf
	cp -f $(NGINX_TEST_PROJECT_PATH)/nginx-test.conf $(NGINX_VOLUMES_CONF)/nginx-test.conf
	sleep 1
	mkdir -p $(NGINX_TEST_VOLUMES)
	cp -f $(NGINX_TEXT_PATH)/index.html $(NGINX_TEST_VOLUMES)


nginx-test: _nginx-test-prepre
	@echo "nginx-test"
	sleep 2
	$(MAKE) nginx-reload

# 	$(MAKE) nginx-reload
# test: nginx-test
test:
# 	docker logs $(NGINX_NAME)
	docker exec -it $(NGINX_NAME_APP_NAME) sh

# 	docker logs $(NGINX_NAME)-$(APP_ENV)
# 	/etc/nginx/http.d/nginx-test.conf
# 	docker exec $(NGINX_NAME)-$(APP_ENV) cat /etc/nginx/http.d/nginx-test.conf
# 	docker exec -it $(NGINX_NAME)-$(APP_ENV) sh


_nginx-test-create-nginx-test-conf:
	@echo "_nginx-test-create-nginx-test-conf"
	mkdir -p $(NGINX_TEST_PROJECT_PATH)
	printf "$$NGINX_TEXT_CONF" > $(NGINX_TEST_PROJECT_PATH)/nginx-test.conf

nginx-test-remove:
	@echo "nginx-test-remove"
	rm -rf $(NGINX_TEST_PROJECT_PATH)
	rm -rf $(NGINX_TEST_VOLUMES)
	rm -f $(NGINX_VOLUMES_CONF)/nginx-test.conf
