# packages-ncc/packages-ncc.mk

PACKAGES_NCC_PROJECT_PATH := $(PROJECT_PATH)/packages-ncc
VOLUMES_PACKAGES_NCC := $(PACKAGES_NCC_PROJECT_PATH)
PACKAGES_NCC_WORKDIR := $(PACKAGES_NCC_APP_PATH)

packages-ncc-git-clone:
	@if [ ! -d $(PACKAGES_NCC_PROJECT_PATH) ]; then \
		echo "packages-ncc-git-clone"; \
		cd $(PROJECT_PATH); \
		git clone git@github.com:hungthuan-nguyenchicong1502/packages-ncc.git; \
	else \
		ls $(PACKAGES_NCC_PROJECT_PATH); \
	fi

packages-ncc-git-pull:
	@if [ -d $(PACKAGES_NCC_PROJECT_PATH) ]; then \
		echo "packages-ncc-git-pull"; \
		cd $(PACKAGES_NCC_PROJECT_PATH); \
		git pull; \
	else \
		make packages-ncc-git-clone; \
	fi

packages-ncc-rm:
	rm -rf $(PACKAGES_NCC_PROJECT_PATH)