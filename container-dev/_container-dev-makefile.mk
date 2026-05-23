# container-dev/_container-dev-makefile.mk

_container-dev/_container-dev-makefile.mk:
	make _container-dev/_container-dev-makefile.mk-cp

_container-dev/_container-dev-makefile.mk-cp:
	rm -rf $(CONTAINER_DEV_PROJECT_PATH)/_makefile
	cp -r ./container-dev/_makefile $(CONTAINER_DEV_PROJECT_PATH)/_makefile