# php-fpm/_app-env-dev/_define-laravel-app-dev-conf.mk

define LARAVEL_APP_DEV_CONF
server {
    listen $(LARAVEL_APP_DEV_CONF_LISTEN);
    server_name $(LARAVEL_APP_DEV_CONF_SERVER_NAME);

    root /var/www/html/laravel-app/public;
    index index.html index.php;

    location / {
        try_files $$uri $$uri/ /index.php?$$args;
    }

    location ~ \.php$$ {
        try_files $$uri =404;

        fastcgi_pass $(LARAVEL_APP_DEV_CONF_FASTCGI_PASS);
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $$document_root$$fastcgi_script_name;
    }
}
endef

export LARAVEL_APP_DEV_CONF