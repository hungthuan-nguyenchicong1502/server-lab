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