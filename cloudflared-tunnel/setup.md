ip addr show

3: docker0: 

inet 172.18.0.1

ssh testuser@ssh_domain -o "ProxyCommand=cloudflared access ssh --hostname %h"

ssh-keygen -R ssh_domain

# cai dat ~/.ssh/authorized_keys
## window
ssh-keygen -t ed25519 -C "authorized_keys_server_lab" -N '""' -f "$HOME\.ssh\id_ed25519_server_lab"

cat ~/.ssh/id_ed25519_server_lab.pub

IdentityFile ~/.ssh/id_ed25519_server_lab

## linux
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

echo "nội-dung-key-của-bạn" >> ~/.ssh/authorized_keys

sshd -t

rc-service sshd restart