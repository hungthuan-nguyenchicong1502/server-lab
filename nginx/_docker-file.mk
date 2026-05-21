# nginx/_docker-file.mk
# docker build -t $(IMAGE_NAME) -f $(PROJECT_NGINX)/Dockerfile $(PROJECT_NGINX)
NGINX_DOCKER_FILE_FILES := $(NGINX_PROJECT_PATH)/Dockerfile

_nginx/_docker-file.mk:
	@echo "nginx/_docker-file.mk"
	make _nginx/_docker-file.mk-create-docker-file

_nginx/_docker-file.mk-create-docker-file:
	@echo "_nginx/_docker-file.mk-create-docker-file"
	printf "$$NGINX_DOCKER_FILE" > $(NGINX_PROJECT_PATH)/Dockerfile
	sleep 1

_nginx-docker-build:
	@echo "nginx-docker-build"
	docker build -t $(NGINX_IMAGE) \
		-f $(NGINX_DOCKER_FILE_FILES) \
		$(NGINX_PROJECT_PATH)