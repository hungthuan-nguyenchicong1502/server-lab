# git/git.mk

git-setting:
	@echo "git-setup: branch origin main"
	make setup
	sleep 1
	make build
	sleep 1
	make setting
	sleep 1
	make up


git-setup:
	@echo "git-setup"
	make setup

git-up:
	@echo "git-up"
	make up

git-down:
	@echo "git-down"
	make laravel-octane-down
	make php-fpm-down
	make nginx-down
	sleep 1
