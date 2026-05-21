# mariadb/_docker-file.mk

MARIADB_DOCKER_FILE_FILES = $(MARIADB_PROJECT_PATH)/Dockerfile

_mariadb/_docker-file.mk:
	@echo "_mariadb/_docker-file.mk"
	make _mariadb/_docker-file.mk-create

_mariadb/_docker-file.mk-create:
	@echo "_mariadb/_docker-file.mk-create"
	printf "$$MARIADB_DOCKER_FILE" > $(MARIADB_PROJECT_PATH)/Dockerfile

_mariadb-docker-build:
	@echo "_mariadb-docker-build"
	docker build -t $(MARIADB_IMAGE) \
		-f $(MARIADB_DOCKER_FILE_FILES) \
		$(MARIADB_PROJECT_PATH)