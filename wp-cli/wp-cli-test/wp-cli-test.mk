# wp-cli/wp-cli-test/wp-cli-test.mk

include wp-cli/wp-cli-test/_create-db-test.mk
include wp-cli/wp-cli-test/_create-wp-cli-app-test.mk

wp-cli-test:
	@echo "wp-cli-test"
	$(MAKE) wp-cli-up
	$(MAKE) _wp-cli/wp-cli-test/_create-db-test.mk
	$(MAKE) _wp-cli/wp-cli-test/_create-wp-cli-app-test.mk
	docker exec -it $(WP_CLI_NAME) sh -c "\
		cd /wp-cli-test && \
		wp server \
			--host=0.0.0.0 \
			--port=8080 \
			--allow-root"