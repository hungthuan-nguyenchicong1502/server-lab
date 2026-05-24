# container-git-clone/_container-git-clone-sh-cp.mk
CONTAINER_GIT_CLONE_SH_SOURCE := ./container-git-clone/container-git-clone.sh
CONTAINER_GIT_CLONE_SH_TARGET := $(CONTAINER_GIT_CLONE_PROJECT_PATH)/container-git-clone.sh

CONTAINER_GIT_CLONE_PROFILE_SH_SOURCE := ./container-git-clone/container-git-clone-profile.sh
CONTAINER_GIT_CLONE_PROFILE_SH_TARGET := $(CONTAINER_GIT_CLONE_PROJECT_PATH)/container-git-clone-profile.sh

_container-git-clone/_container-git-clone-sh-cp.mk:
	make _container-git-clone/_container-git-clone-sh-cp.mk-cp
	make _container-git-clone/_container-git-clone-sh-cp.mk-cp-profile-sh

_container-git-clone/_container-git-clone-sh-cp.mk-cp:
	cp -f $(CONTAINER_GIT_CLONE_SH_SOURCE) $(CONTAINER_GIT_CLONE_SH_TARGET)

_container-git-clone/_container-git-clone-sh-cp.mk-cp-profile-sh:
	cp -f $(CONTAINER_GIT_CLONE_PROFILE_SH_SOURCE) $(CONTAINER_GIT_CLONE_PROFILE_SH_TARGET)


