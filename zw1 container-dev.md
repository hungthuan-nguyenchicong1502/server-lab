# lwarn

Host myalpine
    HostName 192.168.2.74
    User root
    Port 2222

## learn

```
services:
  container-dev:
    image: container-dev-alpine-ncc
    volumes:
      - /home/ncc/app/laravel-project:/var/www/laravel-app

  laravel-app:
    image: laravel-alpine-ncc-v1.0.0
    volumes:
      - /home/ncc/app/laravel-project:/var/www/html
```

```
# 1. Con dev tự pull code của nó về trước
git pull origin main

# 2. Định cư code sạch sang thư mục của con App thông qua lệnh docker exec
# (Mượn lệnh tar để nén dữ liệu từ con dev và xả thẳng vào con app qua đường ống Docker)
tar -cf - . | docker exec -i laravel-alpine-ncc tar -xf - -C /var/www/html
```

```
# Đặt trong file ~/.bashrc của Container Dev
alias update-code="git pull origin main && docker exec -t laravel-octane-alpine-ncc-main php artisan octane:reload"
```

```
services:
  laravel-octane:
    image: laravel-octane-alpine-ncc-v1.0.0
    volumes:
      # Mount toàn bộ cụm thư mục cha vào
      - /home/ncc/app:/var/www/app
    # Đặt thư mục làm việc của container là thư mục current
    working_dir: /var/www/app/current
```
> ln -sfn /home/ncc/app/main /home/ncc/app/current

docker exec laravel-octane-alpine-ncc-main php artisan octane:reload

rsync -a --delete /var/www/app/main/ /var/www/app/stable_backup/

rsync -a --delete /var/www/app/stable_backup/ /var/www/app/main/ && docker exec laravel-octane-alpine-ncc-main php artisan octane:reload

```
/home/ncc/app/
├── .env.dev            # File cấu hình riêng cho Dev
├── .env.main           # File cấu hình riêng cho Main/Staging
├── dev/                # Thư mục code dev
├── main/               # Thư mục code ổn định
└── current/            # Symlink trỏ tới dev hoặc main
```

```
services:
  laravel-app:
    image: laravel-octane-alpine-ncc-v1.0.0
    volumes:
      - /home/ncc/app/current:/var/www/html
    # Ép container ăn file env cố định của môi trường đó
    env_file:
      - /home/ncc/app/.env.main
```

```
#!/bin/bash
# 1. Bẻ ghi đường ray sang thư mục mong muốn
ln -sfn /home/ncc/app/main /home/ncc/app/current

# 2. Đi vào container Octane để dọn dẹp cache cũ của Laravel
docker exec laravel-octane-alpine-ncc-main php artisan config:cache
docker exec laravel-octane-alpine-ncc-main php artisan route:cache

# 3. Ép Octane giải phóng RAM cũ, nạp code từ đường ray mới vào
docker exec laravel-octane-alpine-ncc-main php artisan octane:reload

echo "Chuyển môi trường thành công!"
```

## learn docker build

```
# --- CHẶNG 1: NỀN TẢNG CHUNG (BASE) ---
FROM alpine:3.20 AS base
RUN apk add --no-cache php83 php83-fpm

# --- CHẶNG 2: MÔI TRƯỜNG DEV (Ghi đè, thêm công cụ debug) ---
FROM base AS development
# Cài thêm công cụ chỉ dùng cho dev
RUN apk add --no-cache git openssh xdebug
# Copy code dev có kèm file cấu hình local
COPY . /var/www/html

# --- CHẶNG 3: MÔI TRƯỜNG PROD (Sạch sẽ, tối ưu) ---
FROM base AS production
# Chỉ copy code sạch, không cài git/openssh/xdebug để bảo mật
COPY ./src /var/www/html
```

```
# Chỉ build bản dev (có SSH, có Git):
docker build --target development -t laravel-alpine:dev .

# Chỉ build bản prod (sạch sẽ, bảo mật):
docker build --target production -t laravel-alpine:prod .
```

```
FROM alpine:3.20
# Khai báo biến môi trường lúc build, mặc định là production
ARG ENVIRONMENT=production

RUN apk add --no-cache php83

# Nếu biến truyền vào là development thì mới cài thêm SSH
RUN if [ "$ENVIRONMENT" = "development" ]; then \
        apk add --no-cache openssh; \
    fi
```
> docker build --build-arg ENVIRONMENT=development -t alpine-app:dev .

## env
docker exec -w /_makefile $(export $(cat .env | xargs) && env | awk -F= '{print "-e " $1}') container-dev-alpine-ncc-feature make

docker exec -w /_makefile $(cat .env | grep -v '^#' | xargs -I {} echo -e "{}") container-dev-alpine-ncc-feature make

# Đọc file .env ở máy thật
ifneq ($(wildcard .env),)
    include .env
    export
endif

# Target chạy test/make inside container
run-make-inside:
	@echo "Chạy make trong container với các biến môi trường..."
	docker exec -w /_makefile \
		-e YOUR_ENV_VAR_1=$(YOUR_ENV_VAR_1) \
		-e YOUR_ENV_VAR_2=$(YOUR_ENV_VAR_2) \
		container-dev-alpine-ncc-feature make

cat ~/.ssh/id_ed25519_win_ncc.pub

CONTAINER_DEV_AUTHORIZED_KEY=ssh-ed25519 AA

Host container-dev
    HostName HostName 192.168.2.74
    User root
    Port 2222
    IdentityFile ~/.ssh/id_ed25519_win_ncc
    #ProxyCommand cloudflared access ssh --hostname %h

# vscode
RUN sed -i 's/AllowTcpForwarding.*/AllowTcpForwarding yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
#     sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
#     sed -i 's/#GatewayPorts.*/GatewayPorts yes/' /etc/ssh/sshd_config

ssh-keygen -t ed25519 -C "authorized_keys-win-ncc" -N '""' -f "$HOME.ssh\id_ed25519_win_ncc"

cat ~/.ssh/id_ed25519_win_ncc.pub

IdentityFile ~/.ssh/id_ed25519_win_ncc

Host ssh-lab-dev HostName ssh-lab.hungthuan.com/dev User root IdentityFile ~/.ssh/id_ed25519_win_ncc ProxyCommand cloudflared access ssh --hostname %h

server
echo "NỘI_DUNG_VỪA_COPY" >> ~/.ssh/authorized_keys

docker compose up -d --force-recreate container-dev