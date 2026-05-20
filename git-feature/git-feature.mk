# git-feature/git-feature.mk

git-feature-help:
	@echo "make git-feature-setup"

git-feature-cat-git-dev-env:
	@echo "git-feature-cat-git-dev-env"
	cat $(HOME)/git-dev/server-lab/.env

git-feature-rm-project:
	@echo "git-feature-rm-project"
	rm -rf $(PROJECT_PATH)

git-feature-setup:
	@echo "git-feature-setup"
	make nginx-setup

git-feature-down:
	@echo "git-feature-down"
	make nginx-down

# use
# make git-feature-rm-project
# make nginx-test