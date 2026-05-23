# mariadb/mariadb.mk

MARIADB_NAME := mariadb-alpine-ncc
MARIADB_PROJECT_PATH := $(SHARE_PROJECT_PATH)/mariadb
MARIADB_VOLUMES_DATA := $(MARIADB_PROJECT_PATH)/mariadb-data
MARIADB_VERSION := v1.0.0
# Dockerfile
MARIADB_IMAGE := $(MARIADB_NAME)-$(MARIADB_VERSION)
MARIADB_NAME_APP_ENV := $(MARIADB_NAME)
# docker-comose.yml
ifeq ($(APP_ENV), feature)
 MARIADB_PROJECT_PATH := $(PROJECT_PATH)/mariadb
 MARIADB_VOLUMES_DATA := $(MARIADB_PROJECT_PATH)/mariadb-data
endif

include mariadb/_define-docker-file.mk
include mariadb/_docker-file.mk
include mariadb/_define-docker-compose-yml.mk
include mariadb/_docker-compose.mk

# test
include mariadb/mariadb-test/mariadb-test.mk

mariadb-help:
	@echo "make mariadb-setup"
	@echo "make mariadb-down"

_mariadb-prepare: _prepare
	@echo "_mariadb-prepare"
	mkdir -p $(MARIADB_PROJECT_PATH)
	mkdir -p $(MARIADB_VOLUMES_DATA)
	cp -f ./mariadb/mariadb.sh $(MARIADB_PROJECT_PATH)

mariadb-setup: _mariadb-prepare
	@echo "mariadb-setup"
	make _mariadb/_docker-file.mk
	make _mariadb/_docker-compose.mk

mariadb-build:
	@echo "mariadb-build"
	make _mariadb-docker-build

mariadb-up:
	@echo "mariadb-up"
	make _mariadb/_docker-compose.mk-up

mariadb-down:
	@echo "mariadb-down"
	make _mariadb/_docker-compose.mk-down

mariadb-down-v:
	@echo "mariadb-down-v"
	make _mariadb/_docker-compose.mk-down-v

mariadb-cli:
	docker exec -it $(MARIADB_NAME_APP_ENV) mariadb
mariadb-logs:
	docker logs $(MARIADB_NAME_APP_ENV)

mariadb-check:
	@echo "mariabd-check"
	@i=0; while [ $$i -lt 20 ]; do \
		if docker exec $(MARIADB_NAME_APP_ENV) mariadb-admin ping -h localhost; then \
			echo "Mariadb is ok:"; \
			break; \
		fi; \
		i=$$((i+1)); \
		echo "Waiting... ($$i)"; \
		sleep 1; \
	done

mariadb-data-remove:
	@echo "mariadb-data-remove"
	docker run -u root --rm -v $(MARIADB_VOLUMES_DATA):/parent $(ALPINE_IMAGE) sh -c "\
		chown -R root:root /parent; \
		chmod -R 777 /parent; \
		rm -rf /parent/mariadb-data"
	rm -rf $(MARIADB_VOLUMES_DATA)