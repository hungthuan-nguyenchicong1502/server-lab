# wp-cli/_docker-file.mk

WP_CLI_DOCKER_FILE_FILES := $(WP_CLI_PROJECT_PATH)/Dockerfile

_wp-cli/_docker-file.mk:
	@echo "_wp-cli/_docker-file.mk"
	make _wp-cli/_docker-file.mk-create

_wp-cli/_docker-file.mk-create:
	@echo "_wp-cli/_docker-file.mk-create"
	printf "$$WP_CLI_DOCKER_FILE" > $(WP_CLI_PROJECT_PATH)/Dockerfile
	sleep 1

_wp-cli-docker-build:
	@echo "_wp-cli-docker-build"
	docker build -t $(WP_CLI_IMAGE) \
		-f $(WP_CLI_DOCKER_FILE_FILES) \
		$(WP_CLI_PROJECT_PATH)
