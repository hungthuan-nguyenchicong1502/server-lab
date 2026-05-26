# container-dev/_container-dev-share-ssh.mk
# ~/.ssh/authorized_keys
CONTAINER_DEV_AUTHORIZED_KEYS_SOURCE := ./container-dev/.ssh/id_ed25519_win_ncc.pub
CONTAINER_DEV_AUTHORIZED_KEYS_TARGET := $(VOLUMES_CONTAINER_DEV_SSH)/authorized_keys
# ~/.ssh/id_ed25519_win_git_server_lab
CONTAINER_DEV_GIT_SSH_SOURCE := ./container-dev/.ssh/id_ed25519_win_git_server_lab
CONTAINER_DEV_GIT_SSH_TARGET := $(VOLUMES_CONTAINER_DEV_SSH)/id_ed25519
_container-dev/_container-dev-share-ssh.mk:
	make _container-dev/_container-dev-share-ssh.mk-cp

_container-dev/_container-dev-share-ssh.mk-cp:
	@if [ -f $(CONTAINER_DEV_AUTHORIZED_KEYS_SOURCE) -a ! -f $(CONTAINER_DEV_AUTHORIZED_KEYS_TARGET) ]; then \
		cat $(CONTAINER_DEV_AUTHORIZED_KEYS_SOURCE) > $(CONTAINER_DEV_AUTHORIZED_KEYS_TARGET); \
	fi

	@if [ -f $(CONTAINER_DEV_GIT_SSH_SOURCE) -a ! -f $(CONTAINER_DEV_GIT_SSH_TARGET) ]; then \
		cat $(CONTAINER_DEV_GIT_SSH_SOURCE) > $(CONTAINER_DEV_GIT_SSH_TARGET); \
	fi

# VOLUMES_CONTAINER_DEV_SSH
container-dev-share-ssh-rm:
	docker run -u root --rm -v $(VOLUMES_CONTAINER_DEV_SSH):/parent $(ALPINE_IMAGE) sh -c "\
		chown -R root:root /parent; \
		chmod -R 777 /parent; \
		rm -rf /parent/.ssh"
	rm -rf $(VOLUMES_CONTAINER_DEV_SSH)