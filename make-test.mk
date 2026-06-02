# make-test.mk

test:
# 	ls $(VOLUMES_PACKAGES_NCC)
	@echo "$(WP_PATH)"
# 	cat $(CONTAINER_DEV_DOCKER_FILE_FILES)
# 	make git-feature-container-dev-test
# 	docker inspect $(CONTAINER_DEV_NAME_APP_ENV) --format '{{.Args}}'
# 	docker exec $(CONTAINER_DEV_NAME_APP_ENV) cat /proc/1/cmdline

# VOLUMES_CONTAINER_DEV_SSH
rm-container-dev-ssh:
	docker run -u root --rm -v $(VOLUMES_CONTAINER_DEV_SSH):/parent $(ALPINE_IMAGE) sh -c "\
		chown -R root:root /parent; \
		chmod -R 777 /parent; \
		rm -rf /parent/.ssh"
	rm -rf $(VOLUMES_CONTAINER_DEV_SSH)