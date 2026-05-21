# php-fpm/_docker-file.mk

PHP_FPM_DOCKER_FILE_FILES := $(PHP_FPM_PROJECT_PATH)/Dockerfile

_php-fpm/_docker-file.mk:
	@echo "_php-fpm/_docker-file.mk"
	make _php-fpm/_docker-file.mk-create-docker-file

_php-fpm/_docker-file.mk-create-docker-file:
	@echo "_php-fpm/_docker-file.mk-create-docker-file"
	printf "$$PHP_FPM_DOCKER_FILE" > $(PHP_FPM_PROJECT_PATH)/Dockerfile
	sleep 1

_php-fpm-docker-build:
	@echo "_php-fpm-docker-build"
	docker build -t $(PHP_FPM_IMAGE) \
		-f $(PHP_FPM_DOCKER_FILE_FILES) \
		$(PHP_FPM_PROJECT_PATH)