openssh

RUN ssh-keygen -A

CMD ["/usr/sbin/sshd", "-D"]

if [ ! -z "$ROOT_PASSWORD" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
    echo "Root password updated successfully"

    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sed -i 's/AllowTcpForwarding.*/AllowTcpForwarding yes/' /etc/ssh/sshd_config
    sed -i 's/#GatewayPorts.*/GatewayPorts yes/' /etc/ssh/sshd_config
fi
exec "$@"
libstdc++

git

# xu ly ssh key git
COPY ./.secret/id_ed25519 /root/.ssh/id_ed25519
# Phai chmod 600 cho file key, khong chi 700 cho thu muc
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/id_ed25519

services:
  alpine-ssh:
    image: alpine
    container_name: alpine_ssh_container
    volumes:
      # Gắn volume 'ssh_data' vào đường dẫn đích trong container
      - ssh_data:/root/.ssh
    stdin_open: true # Giữ container chạy để bạn có thể vào thực hiện lệnh
    tty: true

volumes:
  # Khai báo named volume
  ssh_data:

  client
ssh-keygen -t ed25519 -C "authorized_keys-win-ncc" -N '""' -f "$HOME.ssh\id_ed25519_win_ncc"

cat ~/.ssh/id_ed25519_win_ncc.pub

IdentityFile ~/.ssh/id_ed25519_win_ncc

Host ssh-lab-dev HostName ssh-lab.hungthuan.com/dev User root IdentityFile ~/.ssh/id_ed25519_win_ncc ProxyCommand cloudflared access ssh --hostname %h

server
echo "NỘI_DUNG_VỪA_COPY" >> ~/.ssh/authorized_keys

ssh-keygen -t ed25519 -C "authorized_keys_laravel_dev" -N '""' -f "$HOME\.ssh\id_ed25519_authorized_keys_laravel_dev"

cat ~/.ssh/id_ed25519_authorized_keys_laravel_dev.pub