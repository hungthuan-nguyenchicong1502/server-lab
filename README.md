# server-lab
test up
# git
git pull origin dev --no-rebase

git branch -d feature/php-fpm

git push origin --delete feature/php-fpm

git fetch origin --prune

# docker
## dọn dẹp tổng thể
Lệnh này sẽ xóa sạch: tất cả container đã dừng, các network không dùng, các images "dangling" (hình ảnh bị treo, không có tag) và build cache.

docker system prune

Nếu bạn muốn xóa tất cả các images không có container nào đang chạy (chứ không chỉ riêng images bị treo), hãy thêm cờ -a:

docker system prune -a

Nếu muốn xóa luôn cả các Volume không dùng đến (dữ liệu của database,...), bạn thêm cờ --volumes

docker system prune -a --volumes

## note
docker network prune -f