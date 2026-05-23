# git-feature/container-dev/_makefile/Makefile
# echo "NỘI_DUNG_VỪA_COPY" >> ~/.ssh/authorized_keys
.DEFAULT_GOAL := setting
CONTAINER_DEV_AUTHORIZED_KEY := $(CONTAINER_DEV_AUTHORIZED_KEY)
setting:
	@echo "setting ssh authorized_keys"
	@mkdir -p /root/.ssh
	@chmod 700 /root/.ssh

	@if [ -z "$(CONTAINER_DEV_AUTHORIZED_KEY)" ]; then \
		echo "Loi: Bien $(CONTAINER_DEV_AUTHORIZED_KEY) dang trong!"; \
		exit 1; \
	fi
	@printf "$(CONTAINER_DEV_AUTHORIZED_KEY)" > /root/.ssh/authorized_keys
	@chmod 600 /root/.ssh/authorized_keys
	@echo "Da cau hinh thanh cong ssh authorized_keys"