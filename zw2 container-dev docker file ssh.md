docker - compose
```
version: '3.8'

services:
  container-dev:
    image: your-alpine-ssh-image
    container_name: container-dev-alpine-ncc-feature
    # Đọc file .env ở máy thật và nạp vào container
    env_file:
      - .env
    # Hoặc chỉ định trực tiếp biến nếu muốn
    environment:
      - CONTAINER_DEV_AUTHORIZED_KEY=${CONTAINER_DEV_AUTHORIZED_KEY}
    ports:
      - "2222:22"
    volumes:
      # Thay vì COPY cứng file Makefile lúc build, bạn mount nguyên thư mục code/makefile vào
      - ./_makefile:/_makefile
    restart: unless-stopped

```

make file
```
# git-feature/container-dev/_makefile/Makefile
.DEFAULT_GOAL := help

# Dòng này giúp đóng băng giá trị từ môi trường truyền vào (nếu có)
CONTAINER_DEV_AUTHORIZED_KEY := $(CONTAINER_DEV_AUTHORIZED_KEY)

help:
	@echo "Setting up authorized_keys từ biến môi trường..."
	@mkdir -p /root/.ssh
	@chmod 700 /root/.ssh
	@if [ -z "$(CONTAINER_DEV_AUTHORIZED_KEY)" ]; then \
		echo "Lỗi: Biến CONTAINER_DEV_AUTHORIZED_KEY đang trống!"; \
		exit 1; \
	fi
	@printf '%s\n' "$(CONTAINER_DEV_AUTHORIZED_KEY)" > /root/.ssh/authorized_keys
	@chmod 600 /root/.ssh/authorized_keys
	@echo "Đã cấu hình SSH Key thành công!"
```

docker file
```
FROM alpine:latest

# Cài đặt SSH và các công cụ cần thiết
RUN apk update && apk add --no-cache openssh make

# Cấu hình SSH tối thiểu
RUN ssh-keygen -A \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# Không cần COPY _makefile hay .env nữa vì Compose sẽ mount qua Volume khi chạy

CMD ["/usr/sbin/sshd", "-D"]
```