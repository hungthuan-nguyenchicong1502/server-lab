# laravel-octane/_laravel-octane-setting.mk

_laravel-octane/_laravel-octane-setting.mk:
	make _laravel-octane/_laravel-octane-setting.mk-setting
	make packages-ncc-git-pull

_laravel-octane/_laravel-octane-setting.mk-setting:
	docker run --rm \
		-v $(VOLUMES_LARAVEL_APP):$(LARAVEL_OCTANE_WORKDIR) \
		-w $(LARAVEL_OCTANE_WORKDIR) \
		$(LARAVEL_OCTANE_IMAGE) sh -c "\
			composer require laravel/octane --quiet;"

_laravel-octane-setting-ls-sfn-uploads:
	docker exec $(NGINX_NAME_APP_ENV) sh -c "\
		ln -sfn $(WP_APP_WORKDIR)/wp-content/uploads \
		$(LARAVEL_OCTANE_WORKDIR)/public/uploads"
	sleep 1
	make nginx-reload