# wp-app/_wp-app-init.mk

include wp-app/_define-wp-app-env.mk
include wp-app/_wp-app-env.mk
include wp-app/_define-wp-app-conf.mk
include wp-app/_wp-app-conf.mk
include wp-app/_create-connect-mariadb.mk

_wp-app/_wp-app-init.mk:
	@echo "wp-app/_wp-app-init.mk"
	make _wp-app/_wp-app-env.mk
	sleep 1;
	make _wp-app/_wp-app-conf.mk
	sleep 1
	make _wp-app/_create-connect-mariadb.mk
	sleep 1
