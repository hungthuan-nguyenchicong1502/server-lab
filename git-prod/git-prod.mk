# git-prod/git-prod.mk

cat-git-dev-env:
	cat ~/git-dev/server-lab/.env

cat-git-env:
	cat ~/git/server-lab/.env

git-prod-down:
	@echo "git-prod-down"
	make nginx-down
	make php-fpm-down