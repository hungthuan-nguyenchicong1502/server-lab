# nginx/nginx-test/_define-nginx-test-conf.mk

define NGINX_TEXT_CONF
server {
    listen $(LISTEN);
    server_name $(SERVER_NAME);

    root $(NGINX_WORKDIR)/nginx-test;
    index index.html index.php;

    location / {
        try_files $$uri $$uri/ =404;
    }
}
endef

export NGINX_TEXT_CONF