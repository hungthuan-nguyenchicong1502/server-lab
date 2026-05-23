# readme
## win
cat ~/.ssh/id_ed25519_win_ncc.pub

echo "NỘI_DUNG_VỪA_COPY" >> ~/.ssh/authorized_keys

```
Host container-dev
    HostName 192.168.2.74
    User root
    Port 2222
    IdentityFile ~/.ssh/id_ed25519_win_ncc
```

chỉ sử dụng trong container

@docker exec -w /_makefile container_name make

## git info.ht
cat ~/.ssh/id_ed25519_win_git_server_lab
```
cat <<EOF > ~/.ssh/config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
EOF
```
## cat ~/.ssh/id_ed25519_win_git_server_lab
cat ~/.ssh/id_ed25519_win_git_server_lab
```
cat <<EOF > ~/.ssh/id_ed25519
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
EOF

```

cat <<EOF > ~/.ssh/id_ed25519
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAA
49xL9YI3AAAAHGluZm8uaHVuZ3RodWFuLmNvbUBnbWFpbC5jb2
-----END OPENSSH PRIVATE KEY-----
EOF

chmod 700 /root/.ssh

chmod 600 /root/.ssh/id_ed25519
## git
ssh -T git@github.com
## compose
working_dir: /_makefile