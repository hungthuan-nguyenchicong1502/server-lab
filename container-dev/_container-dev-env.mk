# container-dev/_container-dev-env.mk
_container-dev/_container-dev-env.mk:
	make _container-dev/_container-dev-env.mk-create

_container-dev/_container-dev-env.mk-create:
	@if [ ! -f $(CONTAINER_DEV_PROJECT_PATH)/.env.container-dev ]; then \
		printf "CONTAINER_DEV_AUTHORIZED_KEY=$(CONTAINER_DEV_AUTHORIZED_KEY)" > $(CONTAINER_DEV_PROJECT_PATH)/.env.container-dev; \
	else \
		echo ".env Da taon tai: $(CONTAINER_DEV_PROJECT_PATH)/.env.container-dev"; \
	fi