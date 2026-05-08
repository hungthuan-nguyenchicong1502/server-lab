.DEFAULT_GOAL :=help
MY_APP_NET = my-app-net
#PROJECT_DIR = $(shell dirname $(PWD))

cloudflared-tunnel.mk

_check-network:
	@docker network inspect $(MY_APP_NET) >/dev/null 2>&1 || docker network create $(MY_APP_NET)
