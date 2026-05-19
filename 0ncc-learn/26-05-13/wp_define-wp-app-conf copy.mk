# wp-app/_define-wp-app-conf.mk

define WP_APP_CONF
server {
    listen $(WP_APP_CONF_LISTEN);
    server_name $(WP_APP_CONF_SERVER_NAME);

    root /var/www/html/wp-app;
    index index.html index.php;

    location / {
        try_files $$uri $$uri/ /index.php?$$args;
    }

    location ~ \.php$$ {
        try_files $$uri =404;

        fastcgi_pass $(WP_APP_CONF_FASTCGI_PASS):9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $$document_root$$fastcgi_script_name;
    }
}
endef

export WP_APP_CONF