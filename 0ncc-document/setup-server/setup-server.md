# Setup server
ssh cong@192.168.2.74

sed -i 's/dl-cdn.alpinelinux.org/mirror.leaseweb.com/g' /etc/apk/repositories

vi /etc/apk/repositories

https://dl-cdn.alpinelinux.org/alpine/v3.19/main
https://dl-cdn.alpinelinux.org/alpine/v3.19/community

https://mirror.leaseweb.com/alpine/latest-stable/main
https://mirror.leaseweb.com/alpine/latest-stable/community

apk update && apk upgrade

reboot

apk add docker docker-cli-compose

rc-update add networking boot

rc-update add docker default

rc-service docker start

rc-service docker status

docker info

docker ps

docker compose version

addgroup cong docker

chown root:docker /var/run/docker.sock

su - cong -c "docker ps"

## log vào công xử ly git

apk add git

ssh-keygen -t ed25519 -C "info.hungthuan.com@gmail.com"

cat ~/.ssh/id_ed25519.pub

ssh -T git@github.com

git config --global user.name "Nguyen Chi Cong" 
git config --global user.email "info.hungthuan.com@gmail.com"

vi /etc/ssh/sshd_config

AllowTcpForwarding yes

apk add libgcc libstdc++

cong@192.168.2.74

apk add make
