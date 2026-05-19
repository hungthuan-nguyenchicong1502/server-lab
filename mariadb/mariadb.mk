# mariadb/mariadb.mk

MARIADB_NAME = mariadb-alpine-ncc
MARIADB_PROJECT_PATH = $(SHARE_PROJECT_PATH)/mariadb
MARIADB_VOLUMES_DATA = $(MARIADB_PROJECT_PATH)/mariadb-data

include mariadb/_define-docker-file.mk
include mariadb/_define-docker-compose-yml.mk
include mariadb/_docker-compose.mk

# test
include mariadb/mariadb-test/mariadb-test.mk

mariadb-help:
	@echo "make mariadb-setup"
	@echo "make mariadb-down"

_mariadb-prepare:
	@echo "_mariadb-prepare"
	mkdir -p $(MARIADB_PROJECT_PATH)
	cp -f ./mariadb/mariadb.sh $(MARIADB_PROJECT_PATH)

mariadb-setup: _mariadb-prepare
	@echo "mariadb-setup"
	$(MAKE) _mariadb/_docker-compose.mk

mariadb-up:
	@echo "mariadb-up"
	$(MAKE) _mariadb/_docker-compose.mk-up

mariadb-down:
	@echo "mariadb-down"
	$(MAKE) _mariadb/_docker-compose.mk-down

mariadb-down-v:
	@echo "mariadb-down-v"
	$(MAKE) _mariadb/_docker-compose.mk-down-v