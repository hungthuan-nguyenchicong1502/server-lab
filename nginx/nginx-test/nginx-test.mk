# nginx/nginx-test/nginx-test.mk
NGINX_TEST_VOLUMES = $(VOLUMES_PROJECT_APP)/nginx-test
NGINX_TEST_PATH = ./nginx/nginx-test

_nginx-test-prepre:
	@echo "_nginx-test-prepre"
	mkdir -p $(NGINX_TEST_VOLUMES)
	cp -f $(NGINX_TEST_PATH)/nginx-test.conf $(NGINX_VOLUMES_CONF)
	cp -f $(NGINX_TEST_PATH)/index.html $(NGINX_TEST_VOLUMES)


nginx-test: _nginx-test-prepre
	@echo "nginx-test"
	docker restart $(NGINX_NAME)

nginx-test-remove:
	@echo "nginx-test-remove"
	rm -rf $(NGINX_TEST_VOLUMES)
	rm -f $(NGINX_VOLUMES_CONF)/nginx-test.conf
