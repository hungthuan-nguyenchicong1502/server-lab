# redis/_docker-file.mk

REDIS_DOCKER_FILE_FILES = $(REDIS_PROJECT_PATH)/Dockerfile

_redis/_docker-file.mk:
	@echo "_redis/_docker-file.mk"
	make redis/_docker-file.mk-create

redis/_docker-file.mk-create:
	@echo "redis/_docker-file.mk-create"
	printf "$$REDIS_DOCKER_FILE" > $(REDIS_PROJECT_PATH)/Dockerfile

_redis-docker-build:
	@echo "redis-docker-build"
	docker build -t $(REDIS_IMAGE) \
		-f $(REDIS_DOCKER_FILE_FILES) \
		$(REDIS_PROJECT_PATH)