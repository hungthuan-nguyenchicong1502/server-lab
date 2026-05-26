netstat -lpt

make container-dev-logs

make container-dev-sh

make _container-dev/_docker-compose.mk

make container-dev-up

ip addr

172.17.0.1/16

ports:
   - "2222:22"

ssh root@<IP_CỦA_MÁY_HOST> -p 2222

ssh root@172.17.0.1 -p 2222

cat /etc/ssh/sshd_config

vi /etc/ssh/sshd_config
passwd root

PermitRootLogin yes
PasswordAuthentication yes

```
FROM ubuntu:latest

# Cài đặt OpenSSH và đặt mật khẩu root là "123456"
RUN apt-get update && apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && echo "root:123456" | chpasswd

# Cấu hình sshd_config cho phép root đăng nhập qua pass
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
```

```
version: '3.8'

services:
  ssh_server:
    image: alpine:latest
    ports:
      - "2222:22"
    # Cài đặt ssh, đổi pass root thành "MySecurePass123", cấu hình sshd và chạy dịch vụ
    command: >
      sh -c "
      apk update && apk add --no-cache openssh &&
      echo 'root:MySecurePass123' | chpasswd &&
      echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config &&
      echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config &&
      ssh-keygen -A &&
      exec /usr/sbin/sshd -D
      "
```

sshd restart

/usr/sbin/sshd restart

/usr/sbin/sshd -t

kill -USR2 1

/usr/sbin/sshd -D

echo "root:cong12345" | chpasswd

passwd root

docker exec -w /app container-name make target_name
# Hoặc dùng cờ -C của make:
docker exec container-name make -C /app target_name

rsync -av --delete ./thu-muc-nguon/ ./thu-muc-dich/

CMD ["sh", "-c", "mkdir -p /root/.ssh && chmod 700 /root/.ssh && if [ -f /tmp/git_id_ed25519 ]; then cp /tmp/git_id_ed25519 /root/.ssh/id_ed25519 && chmod 600 /root/.ssh/id_ed25519; fi && exec /usr/sbin/sshd -D -e"]

## yml
```
services:
  container-dev-alpine-ncc-dev:
    image: container-dev-alpine-ncc
    container_name: container-dev-alpine-ncc-dev
    init: true
    restart: always
    networks:
      - container-dev-alpine-ncc-dev-net
    ports:
      - "2222:22"
    env_file:
      - ./.env.container-dev
    
    volumes:
      # 1. Volume độc lập cho .ssh (Không lo mất file config, known_hosts khi up/down)
      - ssh_data_container_dev:/root/.ssh
      
      # 2. Chỉ mount duy nhất file key Git từ máy ngoài vào một thư mục tạm
      - /home/cong/share/project-server-lab/container-dev/.ssh/id_ed25519:/tmp/git_id_ed25519:ro

networks:
  container-dev-alpine-ncc-dev-net:
    external: true
    name: my-app-net

# Khai báo Named Volume ở cuối file
volumes:
  ssh_data_container_dev:
```