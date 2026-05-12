# add git

apk add --no-cache openssh-client git

git init

# Thay URL bằng URL repository của bạn
git remote add origin git@github.com:hungthuan-nguyenchicong1502/ten-repo-moi.git

git add .
git commit -m "feat: initial laravel base setup with docker"

git push -u origin main

## hop nhat

git pull origin main --rebase

git push -u origin main

git remote -v

git remote set-url origin git@github.com:hungthuan-nguyenchicong1502/server-lab.git

git@github.com:hungthuan-nguyenchicong1502/server-lab-docker-dev-laravel.git

# 1. Đổi URL về cái tên đang tồn tại trên GitHub
git remote set-url origin git@github.com:hungthuan-nguyenchicong1502/server-lab.git

# 2. Kiểm tra lại kết nối (Lệnh này phải chạy được thì mới Pull được)
git ls-remote origin

GIT_SSH_COMMAND="ssh -v" git ls-remote origin

# Khởi động agent
eval `ssh-agent -s`

# Thêm chìa khóa của bạn vào agent
ssh-add ~/.ssh/id_ed25519  # Hoặc id_rsa tùy tên file của bạn

echo $SSH_AUTH_SOCK

ls -la $SSH_AUTH_SOCK

SSH_AUTH_SOCK=$SSH_AUTH_SOCK git ls-remote origin

ssh-add -l

ssh-add C:\Users\YourUser\.ssh\id_ed25519_cong_project  # Đường dẫn tới key thứ 2

# Tài khoản Cá nhân (Mặc định)
    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/id_ed25519_personal

    # Tài khoản Dự án (Dùng một Alias khác)
    Host github-project
      HostName github.com
      User git
      IdentityFile ~/.ssh/id_ed25519_work
    ```

2.  **Thay đổi URL Remote trong Container:**
    Thay vì dùng `git@github.com:...`, bạn đổi thành alias đã đặt:
    
```bash
    git remote set-url origin git@github-project:hungthuan-nguyenchicong1502/server-lab-docker-dev-laravel.git
    ```

---

### 3. Cách "Ép" VS Code mount đúng Key (Dành cho Dev Container)
Nếu bạn muốn VS Code chỉ lấy đúng một Key duy nhất khi chui vào container đó, bạn có thể can thiệp vào biến môi trường trong file `.devcontainer/devcontainer.json`:

```json
{
  "containerEnv": {
    "GIT_SSH_COMMAND": "ssh -i /root/.ssh/id_specific_key -o StrictHostKeyChecking=no"
  },
  "mounts": [
    "source=C:/Users/YourUser/.ssh/id_project,target=/root/.ssh/id_specific_key,type=bind"
  ]
}


# 1. Đặt chế độ khởi động của SSH Agent thành Automatic
Set-Service -Name ssh-agent -StartupType Automatic

# 2. Khởi động dịch vụ ngay lập tức
Start-Service ssh-agent

# 3. Kiểm tra xem dịch vụ đã chạy chưa
Get-Service ssh-agent

# Nạp key tài khoản cá nhân
ssh-add C:\Users\Admin\.ssh\id_ed25519_personal

# Nạp key tài khoản dự án (Key bạn muốn dùng trong Container)
ssh-add C:\Users\Admin\.ssh\id_ed25519_cong_project