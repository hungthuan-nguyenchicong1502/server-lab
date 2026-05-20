# laravel-octane/_define-laravel-octane-conf.mk
define LARAVEL_OCTANE_CONF
server {
    listen $(LISTEN);
    server_name $(SERVER_NAME);

    root $(LARAVEL_OCTANE_WORKDIR_APP_ENV)/public;
    index index.php;

    # Ưu tiên bắt các file tĩnh trước
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|otf)$$ {
        root /var/www/html/laravel-app/public;
        log_not_found off;
        #access_log on; # Bật lên để check log cho chắc
        #add_header X-Static-Source "Nginx-Handled"; # Thêm header này để test
        #expires max;
        
        # Cực kỳ quan trọng: Nếu không thấy file thì trả về 404 luôn
        # Chứ không được nhảy sang @octane
        try_files $$uri =404;
    }

    location / {
        # Kiểm tra file tĩnh, nếu không thấy thì đẩy vào @octane
        try_files $$uri $$uri/ @octane;
    }

    # Chặn đứng lỗi Download cho file .php
    location ~ \.php$$ {
        # Nếu người dùng gõ trực tiếp hungthuan.com/index.php 
        # Chúng ta rewrite nó về / để Octane không báo 404
        rewrite ^/index\.php/?(.*)$$ /$$1 break;
        
        # Sau đó đẩy sang @octane để xử lý chung một chỗ
        # goto @octane; 
        # Lưu ý: Nginx không có lệnh goto, mình dùng proxy_pass trực tiếp bên dưới
        try_files $$uri @octane;
        # include /etc/nginx/proxy_params; # Nếu bạn có file này, hoặc copy cụm proxy_set_header bên dưới
        # proxy_pass http://laravel-octane-alpine-ncc:1000;
    }

    location @octane {
        proxy_http_version 1.1;
        proxy_set_header Host $$http_host;
        proxy_set_header Scheme $$scheme;
        proxy_set_header SERVER_PORT $$server_port;
        proxy_set_header REMOTE_ADDR $$remote_addr;
        proxy_set_header X-Forwarded-For $$proxy_add_x_forwarded_for;
        proxy_set_header Upgrade $$http_upgrade;
        proxy_set_header Connection "upgrade";

        # Đảm bảo Nginx không gửi /index.php mà gửi đúng URI gốc
        # Nếu vào trang chủ, Octane sẽ nhận được "/"
        proxy_pass http://$(LARAVEL_OCTANE_NAME_APP_ENV):1000;
    }

    location ~ /\. {
        deny all;
    }
}
endef

export LARAVEL_OCTANE_CONF