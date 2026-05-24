# container-dev/_container-dev-sh-cp.mk

CONTAINER_DEV_SH_SOURCE := ./container-dev/container-dev.sh
CONTAINER_DEV_SH_TARGRT := $(CONTAINER_DEV_PROJECT_PATH)/container-dev.sh
_container-dev/_container-dev-sh-cp.mk:
	make _container-dev/_container-dev-sh-cp.mk-cp

_container-dev/_container-dev-sh-cp.mk-cp:
	cp -f $(CONTAINER_DEV_SH_SOURCE) $(CONTAINER_DEV_SH_TARGRT)
