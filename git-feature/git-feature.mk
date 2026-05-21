# git-feature/git-feature.mk

git-feature-help:
	@echo "make git-feature-setup"

git-feature-cat-git-dev-env:
	@echo "git-feature-cat-git-dev-env"
	cat $(HOME)/git-dev/server-lab/.env

# test:
# 	ls $(VOLUMES_PROJECT_APP)

git-feature-rm-project:
	@echo "git-feature-rm-project"
	docker run -u root --rm -v $(VOLUMES_PROJECT_APP):/parent $(ALPINE_IMAGE) sh -c "\
		chown -R root:root /parent; \
		chmod -R 775 /parent; \
		rm -rf /parent/laravel-app; \
		rm -rf /parent/wp-app"
	rm -rf $(PROJECT_PATH)

git-feature-rm-laravel-app:
	@echo "git-feature-rm-project"
	docker run -u root --rm -v $(VOLUMES_LARAVEL_APP):/parent $(ALPINE_IMAGE) sh -c "rm -rf /parent/home/project/laravel-app"
# 	docker run -u root --rm -v $(VOLUMES_LARAVEL_APP):/home/project/laravel-app $(ALPINE_IMAGE) sh -c "rm -rf /home/project/laravel-app"
git-feature-rm-wp-app:
	@echo "git-feature-rm-project"
	docker run -u root --rm -v $(VOLUMES_WP_APP):/parent $(ALPINE_IMAGE) sh -c "rm -rf /parent/home/project/wp-app"


git-feature-setup:
	@echo "git-feature-setup"
	make nginx-setup
	make php-fpm-setup
	make wp-cli-setup
	make wp-app-setup
# 	make laravel-setup
# 	make laravel-octane-setup

	sleep 2
	make git-feature-up
	make php-fpm-up
	make wp-cli-up
	sleep 1
	make wp-cli-down
	sleep 1
	make wp-app-create-project-wp-app
	

	sleep 1
	make nginx-reload

git-feature-build:
	make nginx-build

git-feature-up:
	make nginx-up

git-feature-down:
	@echo "git-feature-down"
	make nginx-down
	make php-fpm-down

# use
# make git-feature-rm-project
# make nginx-test
# make php-fpm-remove-test

# fix
# $(LARAVEL_VOLUMES_LARAVEL_APP)

# test:
# 	ls -ld $(VOLUMES_LARAVEL_APP)

# 	/home/cong/git-feature/project-server-lab/volumes/project-app/laravel-app
# sudo chown -R :cong /home/cong/git-feature/project-server-lab/volumes/project-app
