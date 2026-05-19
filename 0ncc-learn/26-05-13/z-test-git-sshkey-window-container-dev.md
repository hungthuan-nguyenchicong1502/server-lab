docker exec php-fpm-alpine-ncc-dev chmod -R 775 /var/www/html/ssh-keygen -t ed25519 -C "inm@gmail.com"

cat ~/.ssh/id_ed25519.pub

ssh -T git@github.com

ssh-keygen -t ed25519 -C "authorized_keys-win-ncc" -N '""' -f "$HOME\.ssh\id_ed25519_win_ncc"

cat ~/.ssh/id_ed25519_win_ncc.pub

# fix
ssh-keygen -t ed25519 -C "info.hungthuan.com@gmail.com" -N '""' -f "$HOME\.ssh\id_ed25519_win_git_server_lab"

cat ~/.ssh/id_ed25519_win_git_server_lab.pub

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDb@gmail.com

ssh-add -v $HOME\.ssh\id_ed25519_win_git_server_lab


ssh-keygen -l -f $HOME\.ssh\id_ed25519_win_git_server_lab

# 1. Đặt chế độ tự động khởi động (để không bị Stopped nữa)
Set-Service -Name ssh-agent -StartupType Automatic

# 2. Khởi động dịch vụ ngay bây giờ
Start-Service ssh-agent

# 3. Kiểm tra lại trạng thái
Get-Service ssh-agent

Stop-Service ssh-agent

Set-Service -Name ssh-agent -StartupType Disabled

Get-Service ssh-agent

ssh-add "$HOME\.ssh\id_ed25519_win_git_server_lab"

ssh-add "$env:USERPROFILE\.ssh\id_ed25519_win_git_server_lab"

mkdir -p ~/.ssh
cat <<EOF > ~/.ssh/config
Host gitserver
    HostName github.com
    User git
    ForwardAgent yes
    IdentitiesOnly no
EOF

Host gitserver
    HostName github.com
    User git
    ForwardAgent yes
    IdentitiesOnly no
    # Thêm dòng này để ưu tiên dùng Agent
    PubkeyAuthentication yes

mkdir -p ~/.ssh
cat <<EOF > ~/.ssh/config
Host gitserver
    HostName github.com
    User git
    ForwardAgent yes
    IdentitiesOnly no
    PubkeyAuthentication yes
EOF

vi

chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519

cat <<EOF > ~/.ssh/config
Host gitserver
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
EOF


cat <<EOF > ~/.ssh/config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
EOF

# Ví dụ trong Makefile của git-dev
deploy-prod:
	git add .
	git commit -m "update từ dev"
	git push origin dev
	cd ../git-prod && git pull origin dev


deploy-prod:
	@echo "--- Dang day code tu DEV len GitHub ---"
	git add .
	git commit -m "Update from Dev: $(shell date +'%Y-%m-%d %H:%M:%S')"
	git push origin dev
	
	@echo "--- Dang cap nhat moi truong PROD ---"
	cd ../git-prod && \
	git pull origin dev && \
	docker exec -it laravel_prod php artisan optimize:clear && \
	docker exec -it laravel_prod php artisan migrate --force