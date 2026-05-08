# php-fpm/php-fpm-test/php-fpm-test.mk


php-fpm-test:
	@echo "php-fpm-test"
	mkdir -p $(VOLUMES_PROJECT_APP)/php-fpm-test
	cp -f ./php-fpm/php-fpm-test/php-fpm-test.conf $(NGINX_VOLUMES_CONF)
	cp -f ./php-fpm/php-fpm-test/index.php $(VOLUMES_PROJECT_APP)/php-fpm-test
	cp -f ./php-fpm/php-fpm-test/phpinfo.php $(VOLUMES_PROJECT_APP)/php-fpm-test
	cp -f ./php-fpm/php-fpm-test/testdb.php $(VOLUMES_PROJECT_APP)/php-fpm-test


	docker restart $(NGINX_NAME)
	docker restart $(PHP_FPM_NAME)

php-fpm-test-remove:
	@echo "php-fpm-test-remove"
	rm -rf$(VOLUMES_PROJECT_APP)/php-fpm-test
	rm -f $(NGINX_VOLUMES_CONF)/php-fpm-test.conf
