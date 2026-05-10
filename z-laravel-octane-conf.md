index index.php;
charset utf-8;

location / {
    try_files $uri $uri/ @octane;
}

location @octane {
    set $suffix "";
    if ($uri = /index.php) {
        set $suffix ?$query_string;
    }

    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;

    # Chuyển tiếp tới Upstream Octane
    proxy_pass http://octane_server$suffix;
}

# Các file tĩnh vẫn để Nginx xử lý trực tiếp cho nhanh
location ~* \.(jpg|jpeg|gif|png|css|js|ico|webp|tiff|ttf|svg)$ {
    expires 365d;
}