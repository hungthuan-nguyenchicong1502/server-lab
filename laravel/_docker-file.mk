# laravel/_docker-file.mk

LARAVEL_DOCKER_FILE_FILES := $(LARAVEL_PROJECT_PATH)/Dockerfile

_laravel/_docker-file.mk:
	@echo "_laravel/_docker-file.mk"
	make laravel/_docker-file.mk-create-docker-file

laravel/_docker-file.mk-create-docker-file:
	@echo "laravel/_docker-file.mk-create-docker-file"
	printf "$$LARAVEL_DOCKER_FILE" > $(LARAVEL_PROJECT_PATH)/Dockerfile
	sleep 1

_laravel-docker-build:
	@echo "_laravel-docker-build"
	docker build -t $(LARAVEL_IMAGE) \
		-f $(LARAVEL_DOCKER_FILE_FILES) \
		$(LARAVEL_PROJECT_PATH)