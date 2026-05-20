# git-dev/git-dev.mk

git-dev-down:
	@echo "git-dev-down"
	make nginx-down
	make php-fpm-down
	make laravel-octane-down

git-dev-up:
	@echo "git-dev-up"
	make laravel-up