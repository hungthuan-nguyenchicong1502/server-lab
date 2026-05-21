# redis/redis.mk

REDIS_NAME := redis-alpine-ncc
REDIS_PROJECT_PATH := $(PROJECT_PATH)/redis
REDIS_VERSION := v1.0.0
# Dockerfile
REDIS_IMAGE = $(REDIS_NAME)-$(REDIS_VERSION)
# docke-compose.yml
REDIS_NAME_APP_ENV := $(REDIS_NAME)-$(APP_ENV)

include redis/_define-docker-file.mk
include redis/_docker-file.mk
include redis/_define-docker-compose-yml.mk
include redis/_docker-compose.mk

_redis-prepare: _prepare
	@echo "_redis-prepare"
	mkdir -p $(REDIS_PROJECT_PATH)


redis-setup: _redis-prepare
	@echo "redis-setup"
	make _redis/_docker-file.mk
	make _redis/_docker-compose.mk

redis-build:
	@echo "redis-build"
	make _redis-docker-build

redis-up:
	@echo "redis-up"
	make _redis/_docker-compose.mk-up

redis-down:
	@echo "redis-down"
	make _redis/_docker-compose.mk-down

redis-logs:
	docker logs $(REDIS_NAME_APP_ENV)