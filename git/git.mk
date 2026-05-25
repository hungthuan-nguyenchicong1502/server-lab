# git/git.mk

git-setup:
	@echo "git-setup: branch origin main"
	make setup
	sleep 1
	make build
	sleep 1
	make setting
	sleep 1
	make up

git-up:
	@echo "git-up"
	make up

git-down:
	@echo "git"
	make laravel-octane-down
	sleep 1
	make php-fpm-down
	sleep 1
	make nginx-down
	sleep 1
