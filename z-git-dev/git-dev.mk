# z-git-dev/git-dev.mk

# laravel
include z-git-dev/_laravel-app.mk

git-dev-setup: _prepare
	@echo "git-dev-setup"
	$(MAKE) _z-git-dev/_laravel-app.mk

git-dev-up:
	@echo "git-dev-up"
	make laravel-app-dev-up