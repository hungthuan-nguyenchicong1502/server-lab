# git-feature/container-dev/container-dev.mk

# CONTAINER_DEV
# CONTAINER_DEV_PROJECT_PATH
# container-dev

CONTAINER_DEV_MAKEFILE_SOURCE = ./git-feature/container-dev/_makefile
CONTAINER_DEV_MAKEFILE_TARGET = /_makefile

# docker exec $(CONTAINER_DEV_NAME_APP_ENV) $(CONTAINER_DEV_TEST)
CONTAINER_DEV_TEST := ls /_makefile
# docker exec -w /root $(CONTAINER_DEV_NAME_APP_ENV) $(CONTAINER_DEV_TEST)
# CONTAINER_DEV_AUTHORIZED_KEY
CONTAINER_DEV_TEST_MAKEFILE_WORKDIR = /_makefile
CONTAINER_DEV_TEST_W_ROOT := make
# git-feature-container-dev

git-feature-container-dev-exec:
	docker exec $(CONTAINER_DEV_NAME_APP_ENV) $(CONTAINER_DEV_TEST)

git-feature-container-dev-exec-w:
	@docker exec -w $(CONTAINER_DEV_TEST_MAKEFILE_WORKDIR) \
		-e CONTAINER_DEV_AUTHORIZED_KEY="$(CONTAINER_DEV_AUTHORIZED_KEY)" \
		$(CONTAINER_DEV_NAME_APP_ENV) $(CONTAINER_DEV_TEST_W_ROOT)

git-feature-container-dev-setup:
	make container-dev-setup
# 

git-feature-container-dev-build:
	make container-dev-build

git-feature-container-dev-up:
	make container-dev-up

git-feature-container-dev-cp-makefile:
	docker exec $(CONTAINER_DEV_NAME_APP_ENV) rm -rf $(CONTAINER_DEV_MAKEFILE_TARGET)
	docker cp $(CONTAINER_DEV_MAKEFILE_SOURCE) $(CONTAINER_DEV_NAME_APP_ENV):$(CONTAINER_DEV_MAKEFILE_TARGET)
	docker restart $(CONTAINER_DEV_NAME_APP_ENV)



# use
# git-feature-container-dev
# container-dev-sh
# container-dev-build
# container-dev-down

git-feature-container-dev-test-setup:
	make container-dev-down
	make git-feature-container-dev-setup
	make git-feature-container-dev-build
	make git-feature-container-dev-up
# 	Makefile
	make git-feature-container-dev-cp-makefile
# 	docker exec => CONTAINER_DEV_TEST
# 	make git-feature-container-dev-exec
	make git-feature-container-dev-exec-w

# use: make git-feature-container-dev-test
git-feature-container-dev-test:
	make git-feature-container-dev-cp-makefile
	make git-feature-container-dev-exec
	make git-feature-container-dev-exec-w