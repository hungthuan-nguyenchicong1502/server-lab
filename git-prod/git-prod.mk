# git-prod/git-prod.mk

git-prod-help:
	@echo "make git-prod-setting"
	@echo "make git-prod-setup"


git-prod-setting:
	@echo "git-prod-setting"
	make git-prod-setup

	make php-fpm-up
	sleep 1
	make wp-app-create-wp-app
	sleep 1
	make laravel-create-laravel-app
	sleep 1
	make laravel-octane-setting
	sleep 1
	make git-prod-up


git-prod-setup: _prepare
	@echo "git-prod-setup"
	make laravel-setup
	make laravel-octane-setup
	make nginx-setup
	make php-fpm-setup
	make redis-setup
	make wp-app-setup
	make wp-cli-setup
	sleep 1

git-prod-up:
	@echo "git-prod-up"
	make redis-up
	sleep 1
	make laravel-octane-up
	sleep 1
	make php-fpm-up
	sleep 5
	make nginx-up

git-prod-down:
	@echo "git-prod-down"
	make redis-down
	make laravel-octane-down
	make php-fpm-down
	make nginx-down

cat-git-dev-env:
	cat ~/git-dev/server-lab/.env

cat-git-env:
	cat ~/git/server-lab/.env
