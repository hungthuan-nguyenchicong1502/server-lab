# redis/redis.mk

REDIS_NAME = redis-alpine-ncc
REDIS_PROJECT_PATH = $(PROJECT_PATH)/redis

include redis/_create-docker-file.mk
include redis/_create-docker-compose-yml.mk
include redis/_docker-compose.mk

_redis-prepare:
	@echo "_redis-prepare"
	mkdir -p $(REDIS_PROJECT_PATH)


redis-setup: _redis-prepare
	@echo "redis-setup"
	$(MAKE) _redis/_create-docker-file.mk
	$(MAKE) _redis/_create-docker-compose-yml.mk
	$(MAKE) _redis/_docker-compose.mk