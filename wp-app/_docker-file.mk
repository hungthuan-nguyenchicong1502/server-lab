# wp-app/_docker-file.mk

WP_APP_DOCKER_FILE_FILES = $(WP_APP_PROJECT_PATH)/Dockerfile

_wp-app/_docker-file.mk:
	@echo "_wp-app/_docker-file.mk"
	make wp-app/_docker-file.mk-create-docker-file

wp-app/_docker-file.mk-create-docker-file:
	@echo "wp-app/_docker-file.mk-create-docker-file:"
	printf "$$WP_APP_DOCKER_FILE" > $(WP_APP_PROJECT_PATH)/Dockerfile
	sleep 1

_wp-app-docker-build:
	@echo "_wp-app-docker-build:"
	docker build -t $(WP_APP_IMAGE) \
		-f $(WP_APP_DOCKER_FILE_FILES) \
		$(WP_APP_PROJECT_PATH)

