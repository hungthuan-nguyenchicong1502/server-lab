# services
if [ -z "$(netstat -lpn | grep nginx)" ]; then \
    echo "true"; \
else \
    echo "false"; \
fi
## nginx
apk add --no-cache nginx

netstat -lpn | grep nginx

ps | grep -v grep | grep -w 'nginx'

## php84-fpm
apk add --no-cache php84-fpm

php-fpm84 -D

netstat -pl | grep php-fpm84

netstat -lpn | grep php-fpm

kill -USR2 22034

kill -USR2 php-fpm

pkill php-fpm

ps | grep -v grep | grep -w 'php-fpm84'

## redis

apk add --no-cache redis

netstat -lpn | grep redis

redis-server

redis-server /etc/redis.conf --daemonize yes

redis-server --daemonize yes

redis-cli shutdown

### redis test
redis-cli -h 127.0.0.1 -p 6379 ping

redis-cli -h <ten_container_redis> -p 6379 ping

## test laravel
cd /home

composer create-project laravel/laravel:^12 laravel-test
### nginx.conf
vi /etc/nginx/http.d/default.conf

:%d

```
server {
    listen 80;
    listen [::]:80;
    server_name localhost;

    # duong dan
    root /home/laravel-test/public;
    index index.htm index.html index.php;

    #client_max_body_size 64M;

    location / {
        # try_files $uri $uri/ =404;
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        try_files $uri =404;

        #fastcgi_pass php-fpm-alpine-ncc:9000;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;

    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
```
nginx -t

nginx -s reoad

### debug
tail -f /var/log/nginx/error.log

tail -f /var/log/php84/error.log

### fix
chown -R nobody:nginx /home/laravel-test/database

chmod 775 /home/laravel-test/database

### fix php-fpm
chown -R nobody:nginx /home/laravel-test/storage

chown -R nobody:nginx /home/laravel-test/bootstrap/cache