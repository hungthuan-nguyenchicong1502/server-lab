# git-feature/container-dev/_makefile/Makefile

# echo "NỘI_DUNG_VỪA_COPY" >> ~/.ssh/authorized_keys
.DEFAULT_GOAL := setup
CONTAINER_DEV_AUTHORIZED_KEY := $(CONTAINER_DEV_AUTHORIZED_KEY)
setup:
	@echo "-->RUN: setup ssh authorized_keys"
	mkdir -p /root/.ssh
	@printf "$(CONTAINER_DEV_AUTHORIZED_KEY)" > ~/.ssh/authorized_keys
	@echo "-->DONE: setup ssh authorized_keys"
