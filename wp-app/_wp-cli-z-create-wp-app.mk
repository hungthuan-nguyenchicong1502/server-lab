# wp-app/_wp-cli-z-create-wp-app.mk

include wp-app/_wp-cli-core-download.mk
include wp-app/_wp-cli-config-create.mk
include wp-app/_wp-cli-config-set.mk
include wp-app/_wp-cli-core-install.mk
include wp-app/_wp-cli-option-update.mk
include wp-app/_wp-cli-db-reset.mk

_wp-app/_wp-cli-z-create-wp-app.mk:
	@echo "_wp-app/_wp-cli-z-create-wp-app.mk"
# 	Run WP_CLI
	@echo "Checking MariaDB..."
	@i=0; while [ $$i -lt 15 ]; do \
		if docker exec $(MARIADB_NAME) mariadb-admin ping -h localhost --silent; then \
			echo "MariaDB is ok!"; \
			break; \
		fi; \
		echo "Waiting... ($$i)"; \
		i=$$((i+1)); \
		sleep 1; \
	done
	make _wp-app/_wp-cli-core-download.mk
	sleep 1
	make _wp-app/_wp-cli-config-create.mk
	sleep 1
	make _wp-app/_wp-cli-config-set.mk
	sleep 1
	make _wp-app/_wp-cli-core-install.mk
	sleep 1
	make _wp-app/_wp-cli-option-update.mk
	sleep 1