# wp-cli/_define-docker-file.mk

WP_CLI_NAME := wp-cli-alpine-ncc
WP_CLI_PROJECT_PATH := $(PROJECT_PATH)/wp-cli
WP_CLI_VERSION := v.1.0.0
# Dockerfile
# docker-compose.yml
WP_CLI_NAME_APP_ENV := $(WP_CLI_NAME)-$(APP_ENV)
WP_CLI_DOCKERFILE := Dockerfile.$(APP_ENV)
WP_CLI_IMAGE := $(WP_CLI_NAME_APP_ENV)-$(WP_CLI_VERSION)

include wp-cli/_define-docker-file.mk
include wp-cli/_define-docker-compose-yml.mk
include wp-cli/_docker-compose.mk

#test
include wp-cli/wp-cli-test/wp-cli-test.mk

_wp-cli-prepare:
	@echo "_wp-cli-prepare"
	mkdir -p $(WP_CLI_PROJECT_PATH)

wp-cli-setup: _wp-cli-prepare
	@echo "wp-cli-setup"
	$(MAKE) _wp-cli/_docker-compose.mk

wp-cli-up:
	@echo "wp-cli-up"
	$(MAKE) _wp-cli/_docker-compose.mk-up

wp-cli-down:
	@echo "wp-cli-down"
	$(MAKE) _wp-cli/_docker-compose.mk-down

wp-cli-down-v:
	@echo "wp-cli-down-v"
	$(MAKE) _wp-cli/_docker-compose.mk-down-v