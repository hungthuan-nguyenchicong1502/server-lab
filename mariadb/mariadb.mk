# mariadb/mariadb.mk

MARIADB_NAME = mariadb-alpine-ncc
MARIADB_PROJECT_PATH = $(PROJECT_PATH)/mariadb

include mariadb/_create-dockerfile.mk
include mariadb/_create-docker-compose-yml.mk
include mariadb/_docker-compose.mk

# test
include mariadb/mariadb-test/mariadb-test.mk

_mariadb-prepare:
	@echo "_mariadb-prepare"
	mkdir -p $(MARIADB_PROJECT_PATH)
	cp -f ./mariadb/mariadb.sh $(MARIADB_PROJECT_PATH)

mariadb-setup: _mariadb-prepare
	@echo "mariadb-setup"
	$(MAKE) _mariadb/_create-dockerfile.mk
	$(MAKE) _mariadb/_create-docker-compose-yml.mk
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