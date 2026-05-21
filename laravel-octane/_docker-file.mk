# laravel-octane/_docker-file.mk

LARAVEL_OCTANE_DOCKER_FILE_FILES = $(LARAVEL_OCTANE_PROJECT_PATH)/Dockerfile

_laravel-octane/_docker-file.mk:
	@echo "laravel-octane/_docker-file.mk"
	make laravel-octane/_docker-file.mk-create-docker-file

laravel-octane/_docker-file.mk-create-docker-file:
	@echo "laravel-octane/_docker-file.mk-create-docker-file"
	printf "$$LARAVEL_OCTANE_DOCKER_FILE" > $(LARAVEL_OCTANE_PROJECT_PATH)/Dockerfile

_laravel-octane-docker-build:
	docker build -t $(LARAVEL_OCTANE_IMAGE) \
		-f $(LARAVEL_OCTANE_DOCKER_FILE_FILES) \
		$(LARAVEL_OCTANE_PROJECT_PATH)