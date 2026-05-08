server {
    listen 80;
    listen [::]:80;
    server_name _;

    # duong dan
    root /var/www/html;
    index index.htm index.html index.php;

    #client_max_body_size 64M;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        try_files $uri =404;

        fastcgi_pass php-fpm-alpine-ncc:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}

server {
    listen 8080;
    listen [::]:8080;
    server_name _;

    # duong dan
    root /var/www/html/wp-app;
    index index.htm index.html index.php;

    #client_max_body_size 64M;

    location / {
        # try_files $uri $uri/ =404;
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        try_files $uri =404;

        fastcgi_pass php-fpm-alpine-ncc:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}

http {
    keepalive_timeout 75s; # Giữ kết nối mở trong 75 giây thay vì 65s mặc định
    keepalive_requests 1000; # Cho phép 1000 yêu cầu trên cùng một kết nối
}

<link rel="dns-prefetch" href="//hungthuan.com">

<link rel="preconnect" href="https://hungthuan.com" crossorigin>

<link rel="preconnect" href="https://hungthuan.com">
<link rel="dns-prefetch" href="https://hungthuan.com">

C:\Windows\System32\drivers\etc\hosts