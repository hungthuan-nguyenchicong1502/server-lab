# wp-app/_create-wp-app.mk

_wp-app/_create-wp-app.mk:
	@echo "_wp-app/_create-wp-app.mk"
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
	$(MAKE) _wp-app/_wp-cli-core-download.mk
	$(MAKE) _wp-app/_wp-cli-config-create.mk
	$(MAKE) _wp-app/_wp-cli-config-set.mk
	$(MAKE) _wp-app/_wp-cli-core-install.mk
	$(MAKE) _wp-app/_wp-cli-option-update.mk