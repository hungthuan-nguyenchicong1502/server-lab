```
location ~ \.php$$ {
        try_files $$uri =404;

        # 1. Tách URL để định nghĩa đúng $fastcgi_script_name và $fastcgi_path_info
        fastcgi_split_path_info ^(.+\.php)(/.+)$$;

        fastcgi_pass $(PHP_FPM_NAME_APP_ENV):9000;
        fastcgi_index index.php;
        include fastcgi_params;
        
        # 2. Khai báo các tham số cấu hình chuẩn cho PHP-FPM
        fastcgi_param SCRIPT_FILENAME $$document_root$$fastcgi_script_name;
        
        # DÒNG CÒN THIẾU CỦA BẠN ĐÂY:
        fastcgi_param PATH_INFO $$fastcgi_path_info;
        
        # Thêm dòng này để hỗ trợ tốt hơn cho một số plugin/theme WP cũ
        fastcgi_param PATH_TRANSLATED $$document_root$$fastcgi_path_info;

        fastcgi_buffer_size 128k;
        fastcgi_buffers 4 256k;
        fastcgi_busy_buffers_size 256k;
    }
```