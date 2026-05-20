# git-feature/git-feature.mk

git-feature-help:
	@echo "make git-feature-setup"

git-feature-cat-git-dev-env:
	@echo "git-feature-cat-git-dev-env"
	cat $(HOME)/git-dev/server-lab/.env

git-feature-rm-project:
	@echo "git-feature-rm-project"
	docker run -u root --rm -v $(VOLUMES_PROJECT_APP):/parent $(ALPINE_IMAGE) sh -c "rm -rf /parent/project-app"
	rm -rf $(PROJECT_PATH)

git-feature-setup:
	@echo "git-feature-setup"
	make nginx-setup
	make php-fpm-setup
	make wp-app-setup
	make laravel-setup

git-feature-down:
	@echo "git-feature-down"
	make nginx-down
	make php-fpm-down

# use
# make git-feature-rm-project
# make nginx-test
# make php-fpm-remove-test