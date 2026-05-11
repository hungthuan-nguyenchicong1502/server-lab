# php-fpm/php-fpm-test/_define-php-fpm-test-conf.mk

define PHP_FPM_TEST_CONF
server {
    listen $(LISTEN);
    server_name $(SERVER_NAME);

    root /var/www/html/php-fpm-test;
    index index.html index.php;

    location / {
        try_files $$uri $$uri/ =404;
    }

    location ~ \.php$$ {
        try_files $$uri =404;

        fastcgi_pass $(FASTCGI_PASS):9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $$document_root$$fastcgi_script_name;
    }
}
endef

export PHP_FPM_TEST_CONF