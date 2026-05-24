-include .env

```
# Kiểm tra nếu file .env tồn tại thực sự trong thư mục
ifneq ($(wildcard .env),)
    include .env
else
    # Bạn có thể định nghĩa các biến fallback (mặc định) ở đây nếu muốn
    ENV_STATUS = "File .env chưa được tạo"
endif

setting-help:
	@echo "Trạng thái cấu hình: $(ENV_STATUS)"
	@echo "Đang chạy lệnh trợ giúp cấu hình..."
```
```
-include .env

# Định nghĩa rule để tự đẻ ra file .env nếu chưa có
.env:
	@echo "Không tìm thấy .env, đang tự động copy từ .env.example..."
	@cp .env.example .env 2>/dev/null || echo "Cảnh báo: Không tìm thấy .env.example để copy!"

setting-help: .env
	@echo "Tiến hành chạy lệnh help..."
```