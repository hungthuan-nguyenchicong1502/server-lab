make laravel-octane-sh

vi .env

composer update

php artisan migrate

php artisan optimize:clear

php artisan octane:reload

## volumes packages-ncc

working_dir: $(LARAVEL_OCTANE_WORKDIR)
  
  volumes:
   - $(VOLUMES_LARAVEL_APP):$(LARAVEL_OCTANE_WORKDIR)
   - $(VOLUMES_PACKAGES_NCC):$(PACKAGES_NCC_WORKDIR)

## setup packages-ncc
make laravel-octane-sh

vi composer.json

```
"require": {
        "ncc/packages-ncc": "dev-main"
    },
    "repositories": [
        {
            "type": "path",
            "url": "../packages-ncc",
            "options": {
                "symlink": true
            }
        }
    ],
```
### view / welcom
vi routes/web.php

composer update

composer dump-autoload

php artisan migrate

php artisan optimize:clear

php artisan octane:reload

## nginx ls -sfn
laravel-octane-link-uploads

```
laravel-app-link-uploads:
	@if [ -d $(WP_APP_PATH)/wp-content/uploads ]; then \
		ln -sfn $(WP_APP_PATH)/wp-content/uploads $(LARAVEL_APP_PATH)/public/uploads; \
	else \
		echo "Error: $(WP_APP_PATH)/wp-content/uploads"; \
	fi
	@echo "laravel-app-link-uploads ok"
```