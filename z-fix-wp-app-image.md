# fix image
docker exec -u root -it php-fpm-alpine-ncc sh

chown -R nobody:nobody /var/www/html
chmod -R 755 /var/www/html

# fix option

# Cập nhật chiều rộng thumbnail lên 400px
docker exec -it -u root php-fpm-alpine-ncc wp option update thumbnail_size_w 400 --allow-root

# Cập nhật chiều cao thumbnail (ví dụ 400px)
docker exec -it -u root php-fpm-alpine-ncc wp option update thumbnail_size_h 400 --allow-root

# Tắt chế độ crop cứng (để ảnh resize theo tỷ lệ)
docker exec -it -u root php-fpm-alpine-ncc wp option update thumbnail_crop 0 --allow-root

define('WP_POST_REVISIONS', 1);

wp config set WP_POST_REVISIONS 1 --raw --path=/wp-app --allow-root
wp option update thumbnail_size_w 400 --autoload=yes --allow-root

wp-app-up

docker exec -it wp-app-alpine-ncc sh

## fix cac option
thumbnail_size_w
medium_size_w
large_size_w

medium_large_size_w

### run
wp option update thumbnail_size_w 400 --autoload=yes --path=/wp-app --allow-root

wp option update thumbnail_size_h 400 --autoload=yes --path=/wp-app --allow-root

wp option update medium_size_w 0 --autoload=no --path=/wp-app --allow-root

wp option update medium_size_h 0 --autoload=no --path=/wp-app --allow-root

wp option update large_size_w 0 --autoload=no --path=/wp-app --allow-root

wp option update large_size_h 0 --autoload=no --path=/wp-app --allow-root

wp option update medium_large_size_w 0 --autoload=no --path=/wp-app --allow-root

wp option update medium_large_size_h 0 --autoload=no --path=/wp-app --allow-root